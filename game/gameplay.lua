local field = require "field"
local player = require "player"
local input = require "input"
local clock = require "clock"
local effects = require "effects"

local gameplay = {}

function gameplay:init()
  self.clock = clock.new()

  effects:init(self.clock)
  field:init(3, self.clock)
  player:init(self.clock)
end

function gameplay:loadLevel(levelFolder)
  local folderPath = 'levels/' .. levelFolder
  local levelPath = folderPath .. '/level.lua'

  local chunk = love.filesystem.load(levelPath)
  local musicFile

  setfenv(chunk, {
    music = function(...) musicFile = ... end,
  })()

  local music = love.audio.newSource(folderPath .. '/' .. musicFile)
  self.clock:schedule(function(wait)
    wait(2)
    music:play()
    wait(0.05)
    effects:start()
  end)
end

function gameplay:update(dt)
  player:update(dt)
  field:update(dt)
  effects:update(dt)
end

function gameplay:keypressed(key)
  if key == 'escape' then
    love.event.quit()
  else
    input:keypressed(key)
  end
end

function gameplay:draw()
  effects:transform(function()
    field:drawBackground()
    field:drawMines()
    player:draw()
  end)
  effects:drawFlash()
end

return gameplay
