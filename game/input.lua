local player = require 'player'

local input = {}

local actions = {
  moveLeft = function() player:move(-1) end,
  moveRight = function() player:move(1) end,
}

local keys = {
  left = actions.moveLeft,
  right = actions.moveRight,
}

function input:keypressed(key)
  local action = keys[key]
  if action then action() end
end

return input
