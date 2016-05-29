local mine = {}
local size = 40

function mine.new(x, y)
  local self = setmetatable({}, { __index = mine })
  self.x = x
  self.y = y
  return self
end

function mine:update(dt)
  self.y = self.y + 500 * dt
end

function mine:draw()
  love.graphics.push()
  love.graphics.translate(self.x, self.y)
  love.graphics.rotate(math.rad(self.y))
  love.graphics.translate(-size / 2, -size / 2)
  love.graphics.rectangle('fill', 0, 0, size, size)
  love.graphics.pop()
end

return mine
