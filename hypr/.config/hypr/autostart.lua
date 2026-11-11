-- Ghostty's config starts Herdr; xdg-terminal-exec would resolve to Foot.
local apps = {
  { command = "ghostty", slot = 1 },
  { command = "zen-browser", slot = 1 },
  { command = "steam", slot = 3 },
  { command = "discord", slot = 4 },
  { command = os.getenv("HOME") .. "/.local/bin/t3code-nightly", slot = 5 },
}

hl.on("hyprland.start", function()
  for index, app in ipairs(apps) do
    hl.timer(function()
      local workspace = o.workspaces.workspace_id(hl.get_monitor("DP-1"), app.slot)
      hl.exec_cmd(app.command, { workspace = workspace .. " silent" })
    end, { type = "oneshot", timeout = 2000 + index * 600 })
  end
end)
