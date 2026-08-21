-- Startup layout restoration: relaunch the usual apps pinned to their
-- workspaces (see startup-layout.sh). Native Quattro session behavior does not
-- restore client windows, evaluated after rebooting into Omarchy 4.0.
hl.on("hyprland.start", function()
  hl.exec_cmd("sleep 2 && bash $HOME/.dotfiles/hypr/.config/hypr/startup-layout.sh")
end)
