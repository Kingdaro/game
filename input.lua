local player = require 'player'

local input = {}

function input:keypressed(key)
  if key == 'right' then
    player:move(1)
  elseif key == 'left' then
    player:move(-1)
  end
end

return input
