-- Restore the desktop monitor arrangement after Quattro's Lua migration.
hl.env("GDK_SCALE", "1")
hl.monitor({ output = "DP-1", mode = "3840x2160@60", position = "0x0", scale = 1.6 })
hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "auto", scale = 1 })
hl.monitor({ output = "HDMI-A-1", disabled = true })

hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-2", default = true })
hl.workspace_rule({ workspace = "3", monitor = "DP-1" })
hl.workspace_rule({ workspace = "4", monitor = "DP-1" })
hl.workspace_rule({ workspace = "5", monitor = "DP-1" })
