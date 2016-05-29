local field = require 'field'
local util = require 'util'

local player = {}

function player:init()
  self.x = 300
  self.y = 700
  self.width = 80
  self.height = 80
  self.lane = 1
end

function player:update(dt)
  self.x = util.interpolate(self.x, field:getLanePosition(self.lane), dt * 20)
end

function player:move(dir)
  self.lane = util.clamp(self.lane + dir, 1, field.laneCount)
end

function player:draw()
  love.graphics.setColor(util.toLoveColor(0.5, 0.2, 0.5))
  love.graphics.rectangle('fill',
    self.x - self.width / 2,
    self.y - self.height / 2,
    self.width, self.height
  )
end

return player
