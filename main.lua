local field = require 'field'
local player = require 'player'
local input = require 'input'
local util = require 'util'

function love.load()
  love.graphics.setBackgroundColor(util.toLoveColor(0.08, 0.02, 0.08))

  field:init(3)
  player:init()
end

function love.update(dt)
  player:update(dt)
  field:update(dt)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  else
    input:keypressed(key)
  end
end

function love.draw()
  player:draw()
  field:draw()
end
