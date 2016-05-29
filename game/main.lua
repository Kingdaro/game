io.stdout:setvbuf('no')

local field = require 'field'
local player = require 'player'
local input = require 'input'
local util = require 'util'

local clock = require 'clock'

local test = clock.new()

test:schedule(function(wait)
  for i=10, 1, -1 do
    print('Counting down, ', i)
    wait(0.8)
  end
  print('Blast off!')
end)

function love.load()
  love.graphics.setBackgroundColor(util.toLoveColor(0.08, 0.02, 0.08))

  field:init(3)
  player:init()
end

function love.update(dt)
  test:update(dt)

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
  field:drawMines()
  player:draw()
end
