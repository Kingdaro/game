local field = require 'field'
local player = require 'player'

function love.load()
  field:init(3)
  player:init(field.laneCount)
end

function love.update(dt)
  player:update(dt)
  field:update(dt)
end

function love.keypressed(key)
  player:keypressed(key)
end

function love.draw()
  player:draw()
  field:draw()
end
