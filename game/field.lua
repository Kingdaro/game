local mine = require "mine"
local clock = require "clock"
local util = require "util"

local field = {}

function field:init(laneCount)
  self.laneCount = laneCount
  self.mines = {}
  self.clock = clock.new()

  self.clock:schedule(function(wait)
    while true do
      self:addMine()
      wait(0.4)
    end
  end)
end

function field:update(dt)
  self.clock:update(dt)
  self:updateMines(dt)
end

function field:addMine()
  local lane = math.random(self.laneCount)
  table.insert(self.mines, mine.new(self:getLanePosition(lane), -100))
end

function field:updateMines(dt)
  for i=#self.mines, 1, -1 do
    local m = self.mines[i]
    m:update(dt)
    if m.y > love.graphics.getHeight() + 100 then
      table.remove(self.mines, i)
    end
  end
end

function field:drawMines()
  for _, m in ipairs(self.mines) do
    m:draw(self.clock.time)
  end
end

function field:drawBackground()
  local screenWidth, screenHeight = love.graphics.getDimensions()
  local spacing = 30
  local width = screenWidth - spacing * 2
  local height = screenHeight - spacing * 2
  love.graphics.setColor(util.toLoveColor(1, 1, 1, 0.02))
  love.graphics.rectangle('fill', spacing, spacing, width, height)
end

function field:getLanePosition(lane)
  return love.graphics.getWidth() / (self.laneCount + 1) * lane
end

return field
