hl.config({
  input = {
    kb_layout = "us",
    kb_options = "caps:swapescape,shift:both_capslock_cancel",
    repeat_rate = 40,
    repeat_delay = 600,
    numlock_by_default = true,
    accel_profile = "flat",
    touchpad = { scroll_factor = 0.4 },
  },
})

o.window("(Alacritty|kitty|foot)", { scroll_touchpad = 1.5 })
o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })
