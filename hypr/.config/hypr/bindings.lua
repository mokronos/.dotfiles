-- SUPER+SHIFT+SPACE is a Quattro bar toggle by default; use it for workspace swapping instead.
hl.unbind("SUPER + SHIFT + SPACE")
hl.unbind("SUPER + L")
o.bind("SUPER + SHIFT + SPACE", "Swap workspaces between monitors", hl.dsp.workspace.swap_monitors({ monitor1 = "current", monitor2 = "+1" }))
o.bind("SUPER + H", "Move workspace to left monitor", hl.dsp.workspace.move({ monitor = "l" }))
o.bind("SUPER + L", "Move workspace to right monitor", hl.dsp.workspace.move({ monitor = "r" }))
