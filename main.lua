
local player = {
  lane = 1,
  x = 300,
  y = 500,
  width = 80,
  height = 80,
}

local lanes = {}
for i=1, 3 do
  lanes[i] = {}
end

local mineTimer = 0
local mineTimerLimit = 0.5

function love.load()
end

function love.update(dt)
  player.x = player.x + (player.lane * 100 - player.x) * math.min(dt, 1) * 20

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
  if key == 'left' then
    player.lane = player.lane > 1 and player.lane - 1 or #lanes
  elseif key == 'right' then
    player.lane = player.lane < #lanes and player.lane + 1 or 1
  end
end

function love.draw()
  love.graphics.rectangle('fill',
    player.x - player.width / 2,
    player.y - player.height / 2,
    player.width, player.height
  )

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
