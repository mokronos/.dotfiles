-- SUPER+SHIFT+SPACE is a Quattro bar toggle by default; use it for workspace swapping instead.
hl.unbind("SUPER + SHIFT + SPACE")
hl.unbind("SUPER + L")
o.bind("SUPER + SHIFT + SPACE", "Swap workspaces between monitors", "hyprctl dispatch swapactiveworkspaces current +1")
o.bind("SUPER + H", "Move workspace to left monitor", "hyprctl dispatch movecurrentworkspacetomonitor l")
o.bind("SUPER + L", "Move workspace to right monitor", "hyprctl dispatch movecurrentworkspacetomonitor r")
o.bind("SHIFT + PRINT", "Screenshot (region)", "omarchy-capture-screenshot region")
