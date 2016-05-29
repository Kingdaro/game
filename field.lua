local field = {}

function field:init(laneCount)
  self.laneCount = laneCount

  self.mines = {}
  self.mineTimer = 0
  self.mineTimerLimit = 0.4
end

function field:update(dt)
  self:updateMines(dt)

  self.mineTimer = self.mineTimer + dt
  while self.mineTimer >= self.mineTimerLimit do
    self.mineTimer = self.mineTimer - self.mineTimerLimit
    self:addMine()
  end
end

function field:updateMines(dt)
  for i=#self.mines, 1, -1 do
    local mine = self.mines[i]
    mine.y = mine.y + 600 * dt
    if mine.y > love.graphics.getHeight() + 100 then
      table.remove(self.mines, i)
    end
  end
end

function field:addMine()
  local lane = math.random(self.laneCount)
  table.insert(self.mines, {
    x = lane * 100,
    y = -100,
  })
end

function field:draw()
  for _, mine in ipairs(self.mines) do
    love.graphics.push()
    love.graphics.translate(mine.x, mine.y)
    love.graphics.rotate(math.rad(mine.y))
    love.graphics.translate(-25, -25)
    love.graphics.rectangle('fill', 0, 0, 50, 50)
    love.graphics.pop()
  end
end

return field
