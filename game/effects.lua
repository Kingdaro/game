local flux = require "lib.flux"

local effects = {}

function effects:init(clock, music)
  self.shake = { x = 0, y = 0 }
  self.flash = 1
  self.flux = flux.group()
  self.clock = clock

  self.clock:schedule(function(wait)
    wait(2)
    music:play()
    wait(0.1)
    while true do
      self.shake.x = 1
      self.shake.y = 1
      self.flux:to(self.shake, 0.3, { x = 0, y = 0 })
      wait(60 / 130)
    end
  end)
end

function effects:update(dt)
  self.flux:update(dt)
end

function effects:transform(draw)
  local sx = (love.math.random() * 2 - 1) * self.shake.x * 12
  local sy = (love.math.random() * 2 - 1) * self.shake.y * 12

  love.graphics.push()
  love.graphics.translate(sx, sy)
  draw()
  love.graphics.pop()
end

return effects
