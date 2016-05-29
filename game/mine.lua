local util = require 'util'

local mine = {}

local innerSize = 25
local outerSize = 12
local outerDistance = 40
local outerCount = 3

function mine:init(x, y)
  self.x = x
  self.y = y
end

function mine:update(dt)
  self.y = self.y + 500 * dt
end

function mine:draw(time)
  local glow = (math.sin(time * 10) / 2 + 0.5) * 0.4

  love.graphics.push('all')

  love.graphics.setColor(util.brighten(glow, 0.8, 0.3, 0.3))
  love.graphics.translate(self.x, self.y)


  for i = 1, outerCount do
    love.graphics.push()
    love.graphics.rotate(math.rad(i * (360 / outerCount) - self.y / 4))
    love.graphics.translate(outerDistance, 0)
    util.rectangle(0, 0, outerSize, nil, -math.rad(self.y / 2))
    love.graphics.pop()
  end

  util.rectangle(0, 0, innerSize, nil, math.rad(self.y / 2))

  love.graphics.pop()
end

function mine.new(...)
  local self = setmetatable({}, { __index = mine })
  mine.init(self, ...)
  return self
end

return mine
