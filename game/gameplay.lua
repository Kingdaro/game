local field = require 'field'
local player = require 'player'
local input = require 'input'

local gameplay = {}

function gameplay:init()
  field:init(3)
  player:init()
end

function gameplay:update(dt)
  player:update(dt)
  field:update(dt)
end

function gameplay:keypressed(key)
  if key == 'escape' then
    love.event.quit()
  else
    input:keypressed(key)
  end
end

function gameplay:draw()
  field:drawBackground()
  field:drawMines()
  player:draw()
end

return gameplay
