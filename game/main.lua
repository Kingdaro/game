io.stdout:setvbuf('no')

local gameplay = require 'gameplay'
local util = require 'util'

function love.load()
  love.graphics.setBackgroundColor(util.toLoveColor(0.08, 0.02, 0.08))
  gameplay:init()
end

function love.update(dt)
  gameplay:update(dt)
end

function love.keypressed(key)
  gameplay:keypressed(key)
end

function love.draw()
  gameplay:draw()
end
