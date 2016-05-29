local util = require "util"

local effects = {}

function effects:init(clock, music)
  self.shake = { x = 0, y = 0 }
  self.clock = clock

  self.clock:schedule(function(wait)
    wait(2)
    music:play()
    wait(0.1)
    while true do
      self.shake.x = 15
      self.shake.y = 15
      wait(60 / 130)
    end
  end)
end

function effects:update(dt)
  self.shake.x = util.interpolate(self.shake.x, 0, dt * 12)
  self.shake.y = util.interpolate(self.shake.y, 0, dt * 12)
end

function effects:transform(draw)
  local sx = love.math.random(-self.shake.x, self.shake.x)
  local sy = love.math.random(-self.shake.y, self.shake.y)

  love.graphics.push()
  love.graphics.translate(sx, sy)
  draw()
  love.graphics.pop()
end

return effects
