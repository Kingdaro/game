local util = require 'util'

local mine = {}

local innerSize = 25
local outerSize = 12
local outerDistance = 40
local outerCount = 3

function mine.new(x, y)
  local self = setmetatable({}, { __index = mine })
  self.x = x
  self.y = y
  self.time = 0
  return self
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
    love.graphics.rectangle('fill', -outerSize / 2, -outerSize / 2, outerSize, outerSize)
    love.graphics.pop()

    love.graphics.pop()
  end

  love.graphics.rotate(math.rad(self.y / 2))
  love.graphics.rectangle('fill', -innerSize / 2, -innerSize / 2, innerSize, innerSize)

  love.graphics.pop()
end

return mine
