local field = require 'field'
local player = require 'player'
local input = require 'input'

local gameplay = {}

function gameplay:init()
  self.music = love.audio.newSource('fragments of darkness.mp3')
  self.music:play()

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
