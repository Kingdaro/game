local field = require "field"
local player = require "player"
local input = require "input"
local clock = require "clock"
local util = require "util"

local gameplay = {}

function gameplay:init()
  self.music = love.audio.newSource('fragments of darkness.mp3')
  self.clock = clock.new()
  self.shake = { x = 0, y = 0 }

  self.clock:schedule(function(wait)
    wait(2)
    self.music:play()
    wait(0.1)
    while true do
      self.shake.x = 20
      wait(60 / 130)
      self.shake.y = 20
      wait(60 / 130)
    end
  end)

  field:init(3, self.clock)
  player:init(self.clock)
end

function gameplay:update(dt)
  player:update(dt)
  field:update(dt)

  self.shake.x = util.interpolate(self.shake.x, 0, dt * 12)
  self.shake.y = util.interpolate(self.shake.y, 0, dt * 12)
end

function gameplay:keypressed(key)
  if key == 'escape' then
    love.event.quit()
  else
    input:keypressed(key)
  end
end

function gameplay:draw()
  local sx = love.math.random(-self.shake.x, self.shake.x)
  local sy = love.math.random(-self.shake.y, self.shake.y)

  love.graphics.push()
  love.graphics.translate(sx, sy)

  field:drawBackground()
  field:drawMines()
  player:draw()

  love.graphics.pop()
end

return gameplay
