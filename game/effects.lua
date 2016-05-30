local flux = require "lib.flux"
local util = require "util"

local effects = {}

function effects:init(clock)
  self.flux = flux.group()
  self.clock = clock

  self.shake = { x = 0, y = 0 }
  self.flash = 0
end

function effects:start()
  self.clock:schedule(function(wait)
    while true do
      self:triggerShake()
      wait(self:beats(1))
    end
  end)

  self.clock:schedule(function(wait)
    wait(self:beats(1))
    while true do
      self:triggerFlash()
      wait(self:beats(2))
    end
  end)
end

function effects:beats(beats)
  return (60 / 130) * beats
end

function effects:triggerFlash()
  self.flash = 1
  self.flux:to(self, 0.3, { flash = 0 })
end

function effects:triggerShake()
  self.shake = { x = 1, y = 1 }
  self.flux:to(self.shake, 0.3, { x = 0, y = 0 })
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

function effects:drawFlash()
  love.graphics.setColor(util.toLoveColor(1, 1, 1, self.flash * 0.1))
  love.graphics.rectangle('fill', 0, 0, love.graphics.getDimensions())
end

return effects
