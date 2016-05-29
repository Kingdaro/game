local flux = require "lib.flux"

local effects = {}

function effects:init(clock)
  self.shake = { x = 0, y = 0 }
  self.flash = 1
  self.flux = flux.group()
  self.clock = clock
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
