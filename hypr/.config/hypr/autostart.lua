local workspaces = require("hypr.workspaces")

-- Ghostty's config starts Herdr; xdg-terminal-exec would resolve to Foot.
local apps = {
  { command = "ghostty", role = "primary", slot = 1 },
  { command = "zen-browser", role = "primary", slot = 1 },
  { command = "obsidian", role = "primary", slot = 3 },
  { command = "/opt/teams-for-linux/teams-for-linux --ozone-platform=x11", role = "laptop", slot = 4 },
  { command = "t3code-nightly", role = "primary", slot = 5 },
}

hl.on("hyprland.start", function()
  for index, app in ipairs(apps) do
    hl.timer(function()
      hl.exec_cmd(app.command, { workspace = workspaces.workspace(app.role, app.slot) .. " silent" })
    end, { type = "oneshot", timeout = 2000 + index * 600 })
  end

  hl.timer(function()
    hl.exec_cmd(string.format(
      "python %s/.dotfiles/hypr/.config/hypr/startup-zen.py %d %d %d",
      os.getenv("HOME"),
      workspaces.workspace("primary", 1),
      workspaces.workspace("laptop", 2),
      workspaces.workspace("laptop", 4)
    ))
  end, { type = "oneshot", timeout = 2000 })
end)
