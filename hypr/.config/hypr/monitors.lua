-- Restore the desktop monitor arrangement after Quattro's Lua migration.
hl.env("GDK_SCALE", "1")
hl.monitor({ output = "DP-1", mode = "3840x2160@60", position = "0x0", scale = 1.6 })
hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "auto", scale = 1 })
