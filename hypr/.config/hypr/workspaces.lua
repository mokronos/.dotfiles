local rules = {}

local function arrange_workspaces()
  local monitors = hl.get_monitors()
  local laptop = hl.get_monitor("eDP-1")
  local primary = laptop or monitors[1]
  for _, monitor in ipairs(monitors) do
    if monitor.name ~= "eDP-1" and not monitor.is_mirror then
      primary = monitor
      break
    end
  end
  if not primary then
    return
  end
  laptop = laptop or primary

  for _, rule in ipairs(rules) do
    rule:set_enabled(false)
  end
  rules = {
    hl.workspace_rule({ workspace = "1", monitor = primary.name, default = true }),
    hl.workspace_rule({ workspace = "r[3-2147483647]", monitor = primary.name }),
    hl.workspace_rule({ workspace = "2", monitor = laptop.name, default = laptop.name ~= primary.name }),
  }

  for _, workspace in ipairs(hl.get_workspaces()) do
    if not workspace.special then
      local target = workspace.id == 2 and laptop or primary
      if not workspace.monitor or workspace.monitor.name ~= target.name then
        hl.dispatch(hl.dsp.workspace.move({ workspace = workspace, monitor = target.name }))
      end
    end
  end
end

local timer = hl.timer(arrange_workspaces, { timeout = 100, type = "oneshot" })
local function schedule_layout()
  timer:set_timeout(100)
end

hl.on("hyprland.start", schedule_layout)
hl.on("monitor.added", schedule_layout)
hl.on("monitor.removed", schedule_layout)
