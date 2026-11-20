-- Open a slow-starting app on the workspace that was active when it was
-- launched, not wherever focus happens to be once its window finally maps.

local MAX_LAUNCH_AGE = 180
local HISTORY_SPAN = 600
local CLOCK_TICKS = 100

local function read(path)
  local file = io.open(path, "r")
  if not file then
    return nil
  end
  local content = file:read("*a")
  file:close()
  return content
end

local function uptime()
  return tonumber(read("/proc/uptime"):match("^(%S+)"))
end

local function stat(pid)
  local content = read("/proc/" .. pid .. "/stat")
  if not content then
    return nil
  end
  local fields = {}
  for field in content:match(".*%) (.*)"):gmatch("%S+") do
    fields[#fields + 1] = field
  end
  return {
    comm = content:match("%((.*)%)"),
    ppid = tonumber(fields[2]),
    start = tonumber(fields[20]) / CLOCK_TICKS,
  }
end

local compositor = tonumber(read("/proc/self/stat"):match("^(%d+)"))

-- The launch is the oldest ancestor below Hyprland or systemd: the process
-- Hyprland spawned directly, or the scope uwsm-app started for the launcher.
local function launch_time(pid)
  local current = stat(pid)
  while current do
    if current.ppid <= 1 or current.ppid == compositor then
      return current.start
    end
    local parent = stat(current.ppid)
    if not parent or parent.comm == "systemd" then
      return current.start
    end
    current = parent
  end
end

local history = {}

local function record()
  local workspace = hl.get_active_workspace()
  if not workspace or workspace.special or workspace.id < 1 then
    return
  end
  local now = uptime()
  if history[#history] and history[#history].id == workspace.id then
    return
  end
  history[#history + 1] = { time = now, id = workspace.id }
  while #history > 1 and history[2].time < now - HISTORY_SPAN do
    table.remove(history, 1)
  end
end

local function workspace_at(time)
  for i = #history, 1, -1 do
    if history[i].time <= time then
      return history[i].id
    end
  end
end

record()
hl.on("workspace.active", record)
hl.on("monitor.focused", record)

-- Windows a rule already sent elsewhere are left where the rule put them.
hl.on("window.open", function(window)
  local active = hl.get_active_workspace()
  if not window.pid or not window.workspace or not active or window.workspace.id ~= active.id then
    return
  end
  local launched = launch_time(window.pid)
  if not launched or uptime() - launched > MAX_LAUNCH_AGE then
    return
  end
  local origin = workspace_at(launched)
  if origin and origin ~= window.workspace.id then
    hl.dispatch(hl.dsp.window.move({ workspace = tostring(origin), follow = false, window = "address:" .. window.address }))
  end
end)
