local util = require 'util'

local mine = {}

local innerSize = 25
local outerSize = 12
local outerDistance = 40
local outerCount = 3

function mine:init(x, y)
  self.x = x
  self.y = y
  self.time = 0
end

function mine:update(dt)
  self.y = self.y + 500 * dt
  self.time = self.time + dt
end

function mine:draw()
  local glow = (math.sin(self.time * 10) / 2 + 0.5) * 0.4

  love.graphics.push('all')

  love.graphics.setColor(util.brighten(glow, 0.8, 0.3, 0.3))
  love.graphics.translate(self.x, self.y)


  for i = 1, outerCount do
    love.graphics.push()
    love.graphics.rotate(math.rad(i * (360 / outerCount) - self.y / 4))
    love.graphics.translate(outerDistance, 0)

    love.graphics.push()
    love.graphics.rotate(-math.rad(self.y / 2))
    util.rectangle(0, 0, outerSize)
    love.graphics.pop()

    love.graphics.pop()
  end

  love.graphics.rotate(math.rad(self.y / 2))
  util.rectangle(0, 0, innerSize)

  love.graphics.pop()
end

function mine.new(...)
  local self = setmetatable({}, { __index = mine })
  mine.init(self, ...)
  return self
end

return mine
