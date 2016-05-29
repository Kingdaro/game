local mine = require 'mine'

local field = {}

function field:init(laneCount)
  self.laneCount = laneCount

  self.mines = {}
  self.mineTimer = 0
  self.mineTimerLimit = 0.4
end

function field:update(dt)
  self:updateMines(dt)

  self.mineTimer = self.mineTimer + dt
  while self.mineTimer >= self.mineTimerLimit do
    self.mineTimer = self.mineTimer - self.mineTimerLimit
    self:addMine()
  end
end

function field:addMine()
  local lane = math.random(self.laneCount)
  table.insert(self.mines, mine.new(self:getLanePosition(lane), -100))
end

function field:updateMines(dt)
  for i=#self.mines, 1, -1 do
    local mine = self.mines[i]
    mine:update(dt)
    if mine.y > love.graphics.getHeight() + 100 then
      table.remove(self.mines, i)
    end
  end
end

function field:getLanePosition(lane)
  return love.graphics.getWidth() / (self.laneCount + 1) * lane
end

function field:draw()
  for _, mine in ipairs(self.mines) do
    mine:draw()
  end
end

return field
