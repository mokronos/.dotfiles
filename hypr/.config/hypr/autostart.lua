-- Startup layout restoration: relaunch the usual apps pinned to their
-- workspaces (see startup-layout.sh). Native Quattro session behavior does not
-- restore client windows, evaluated after rebooting into Omarchy 4.0.

-- TEMPORARY DEBUG instrumentation -- remove once startup restoration confirmed
local function dbg_mark(msg)
  local f = io.open(os.getenv("HOME") .. "/.local/state/omarchy/startup-restore-debug.log", "a")
  if f then
    f:write(os.date("%Y-%m-%d %H:%M:%S") .. " [lua] " .. msg .. "\n")
    f:close()
  end
end

dbg_mark("module evaluated")

hl.on("hyprland.start", function()
  dbg_mark("START EVENT: handler fired")
  hl.exec_cmd("sleep 2 && bash $HOME/.dotfiles/hypr/.config/hypr/startup-layout.sh")
end)

dbg_mark("handlers registered")
