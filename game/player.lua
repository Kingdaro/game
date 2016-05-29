local field = require 'field'
local util = require 'util'

local player = {}

function player:init(clock)
  self.x = 300
  self.y = 700
  self.size = 70
  self.rotation = 0
  self.lane = 1
  self.clock = clock
end

function player:update(dt)
  local pos = field:getLanePosition(self.lane)
  self.x = util.interpolate(self.x, pos, dt * 8)
  self.rotation = util.interpolate(self.rotation, (pos - self.x) / 5, dt * 10)
end

function player:move(dir)
  self.lane = util.clamp(self.lane + dir, 1, field.laneCount)
end

function player:draw()
  local hover = math.sin(self.clock.time * 3) * 15
  local tilt = math.sin(self.clock.time * 2) * 5 + self.rotation

  love.graphics.setColor(util.toLoveColor(0.5, 0.2, 0.5))
  util.rectangle(self.x, self.y + hover, self.size, nil, math.rad(tilt))
end

return player
