local M = {}

local function monitors()
  local laptop = hl.get_monitor("eDP-1")
  local primary = laptop
  for _, monitor in ipairs(hl.get_monitors()) do
    if monitor.name ~= "eDP-1" and not monitor.is_mirror then
      primary = monitor
      break
    end
  end
  return { primary = primary, laptop = laptop or primary }
end

function M.workspace(role, slot)
  local monitor = monitors()[role]
  return monitor and o.workspaces.workspace_id(monitor, slot)
end

local apps = {
  { class = "md\\.obsidian\\.Obsidian", role = "primary", slot = 3 },
  { class = "teams-for-linux", role = "laptop", slot = 4 },
  { class = "com\\.t3tools\\.T3Code", role = "primary", slot = 5 },
}

local rules = {}

local function place_apps()
  for _, rule in ipairs(rules) do
    rule:set_enabled(false)
  end
  rules = {}
  for _, app in ipairs(apps) do
    local workspace = M.workspace(app.role, app.slot)
    if workspace then
      rules[#rules + 1] = hl.window_rule({ match = { class = app.class }, workspace = workspace .. " silent" })
    end
  end
end

local timer = hl.timer(place_apps, { timeout = 100, type = "oneshot" })
local function schedule()
  timer:set_timeout(100)
end

hl.on("hyprland.start", schedule)
hl.on("monitor.added", schedule)
hl.on("monitor.removed", schedule)

return M
