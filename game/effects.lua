local flux = require "lib.flux"
local util = require "util"

local effects = {}

function effects:init(clock)
  self.flux = flux.group()
  self.clock = clock
  self.time = 0
  self.playing = false

  self.shake = { x = 0, y = 0 }
  self.flash = 0
  self.swirl = { enabled = false, angle = 0, magnitude = 15 }
end

function effects:start()
  self.playing = true

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
  if not self.playing then return end
  self.time = self.time + dt

  if self:beats(0) <= self.time and self.time < self:beats(1)
  or self:beats(16) <= self.time and self.time < self:beats(17)
  then
    self.swirl.enabled = true
  else
    self.swirl.enabled = false
  end

  self.flux:update(dt)
  self.swirl.angle = self.swirl.angle + dt * 360 + 180
end

function effects:transform(draw)
  local sx = (love.math.random() * 2 - 1) * self.shake.x * 12
  local sy = (love.math.random() * 2 - 1) * self.shake.y * 12

  love.graphics.push()
  love.graphics.translate(sx, sy)

  if self.swirl.enabled then
    love.graphics.translate(
      math.cos(math.rad(self.swirl.angle)) * self.swirl.magnitude,
      math.sin(math.rad(self.swirl.angle)) * self.swirl.magnitude
    )
  end
  draw()
  love.graphics.pop()
end

function effects:drawFlash()
  love.graphics.setColor(util.toLoveColor(1, 1, 1, self.flash * 0.1))
  love.graphics.rectangle('fill', 0, 0, love.graphics.getDimensions())
end

return effects
