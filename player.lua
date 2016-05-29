local player = {}

function player:init(maxLanes)
  self.x = 300
  self.y = 500
  self.width = 80
  self.height = 80
  self.lane = 1
  self.maxLanes = maxLanes
end

function player:update(dt)
  self.x = self.x + (self.lane * 100 - self.x) * math.min(dt, 1) * 20
end

function player:keypressed(key)
  if key == 'left' then
    self.lane = self.lane > 1 and self.lane - 1 or self.maxLanes
  elseif key == 'right' then
    self.lane = self.lane < self.maxLanes and self.lane + 1 or 1
  end
end

function player:draw()
  love.graphics.rectangle('fill',
    self.x - self.width / 2,
    self.y - self.height / 2,
    self.width, self.height
  )
end

return player
