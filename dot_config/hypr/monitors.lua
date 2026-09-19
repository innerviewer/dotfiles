-- ~/.config/hypr/custom/monitors.lua
-- Custom monitor configuration and persistent workspace assignments

-- hl.env("GDK_SCALE", "1.75")
hl.monitor({ output = "HDMI-A-1", mode = "3840x2160@60", position = "1920x0", scale = 1.6 })
hl.monitor({ output = "DP-1", mode = "1920x1080@165", position = "0x0", scale = 1 })

-- Persistent workspaces 1-10 on HDMI-A-1
for w = 1, 10 do
	hl.workspace_rule({ workspace = tostring(w), monitor = "HDMI-A-1", persistent = true })
end

-- Persistent workspaces 11-20 on DP-1
for w = 11, 20 do
	hl.workspace_rule({ workspace = tostring(w), monitor = "DP-1", persistent = true })
end
