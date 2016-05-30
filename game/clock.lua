local clock = {}

function clock:init()
  self.time = 0
  self.tasks = {}
end

function clock:update(dt)
  self.time = self.time + dt

  for i = #self.tasks, 1, -1 do
    local task = self.tasks[i]
    task.delay = task.delay - dt
    while task.delay <= 0 do
      assert(coroutine.resume(task.routine))
      if coroutine.status(task.routine) == 'dead' then
        table.remove(self.tasks, i)
        break
      end
    end
  end
end

function clock:schedule(func)
  local task = { routine = coroutine.create(func), delay = 0 }
  local function wait(delay)
    task.delay = task.delay + (delay or 0)
    coroutine.yield(task.routine)
  end
  assert(coroutine.resume(task.routine, wait))
  table.insert(self.tasks, task)
end

function clock.new()
  local self = setmetatable({}, { __index = clock })
  clock.init(self)
  return self
end

return clock
