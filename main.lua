local player = require 'player'

local lanes = {}
for i=1, 3 do
  lanes[i] = {}
end

local mineTimer = 0
local mineTimerLimit = 0.5

function love.load()
  player:init(#lanes)
end

function love.update(dt)
  player:update(dt)

  for _, lane in ipairs(lanes) do
    for i = #lane, 1, -1 do
      local mine = lane[i]
      mine.y = mine.y + 600 * dt
      if mine.y > love.graphics.getHeight() + 100 then
        table.remove(lane, i)
      end
    end
  end

  mineTimer = mineTimer + dt
  while mineTimer >= mineTimerLimit do
    mineTimer = mineTimer - mineTimerLimit

    local lane = love.math.random(#lanes)
    table.insert(lanes[lane], {
      x = lane * 100,
      y = -100,
    })
  end
end

function love.keypressed(key)
  player:keypressed(key)
end

function love.draw()
  player:draw()

  for i, lane in ipairs(lanes) do
    for _, mine in ipairs(lane) do
      love.graphics.push()
      love.graphics.translate(i * 100, mine.y)
      love.graphics.rotate(math.rad(mine.y))
      love.graphics.translate(-25, -25)
      love.graphics.rectangle('fill', 0, 0, 50, 50)
      love.graphics.pop()
    end
  end
end
