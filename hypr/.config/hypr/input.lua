hl.config({
  input = {
    -- Use multiple keyboard layouts and switch between them with Left Alt + Right Alt
    kb_layout = "us,de",
    kb_options = "caps:swapescape,shift:both_capslock_cancel,grp:alts_toggle",
    repeat_rate = 40,
    repeat_delay = 600,
    numlock_by_default = true,
    accel_profile = "flat",
    touchpad = { scroll_factor = 0.4 },
  },
})

o.window("(Alacritty|kitty|foot)", { scroll_touchpad = 1.5 })
o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })
