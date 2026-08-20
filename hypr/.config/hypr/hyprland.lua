-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")
require("default.hypr.omarchy")
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")
require("default.hypr.toggles")

o.window(".*", { opacity = "1.0 1.0" })
o.window("steam", { workspace = "3 silent" })
o.window("discord", { workspace = "4 silent" })
o.window("t3code", { workspace = "5 silent" })
