-- ~/.config/hypr/custom/autostart.lua
-- User autostart applications on designated workspaces

hl.on("hyprland.start", function()
  hl.exec_cmd("[workspace 10 silent] uwsm app -- steam")
  hl.exec_cmd("[workspace 11 silent] uwsm app -- flatpak run com.discordapp.Discord")
  hl.exec_cmd("[workspace 13 silent] uwsm app -- AyuGram")
  hl.exec_cmd("[workspace 15 silent] uwsm app -- obs")
end)
