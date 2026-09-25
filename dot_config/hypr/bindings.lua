-- ~/.config/hypr/custom/bindings.lua
-- Custom keybindings: shortcuts, app launchers, vim navigation, and workspace control

-- Unbind default shortcuts that conflict with custom preferences
hl.unbind("SUPER + F")
hl.unbind("SUPER + O")
hl.unbind("SUPER + SLASH")
hl.unbind("SUPER + J")
hl.unbind("SUPER + K")
hl.unbind("SUPER + L")
hl.unbind("SUPER + SHIFT + S")
hl.unbind("SUPER + SHIFT + B")
hl.unbind("SUPER + RETURN")
hl.unbind("SUPER + ALT + RETURN")
hl.unbind("SUPER + SPACE")
hl.unbind("SUPER + S")
hl.unbind("SUPER + ALT + S")
hl.unbind("SUPER + ALT + G")
hl.unbind("SUPER + CTRL + K")
hl.unbind("SUPER_L")

-- Terminals & Sessions
o.bind("SUPER + RETURN", "Terminal", 'uwsm app -- $TERMINAL --working-directory="$(omarchy-cmd-terminal-cwd)"')
o.bind("SUPER + ALT + RETURN", "Tmux", 'uwsm-app -- xdg-terminal-exec --dir="$(omarchy-cmd-terminal-cwd)" tmux new')

-- Window Sizing
o.bind("SUPER + F", "Full width", hl.dsp.window.fullscreen({ mode = "maximized" }))
o.bind("SHIFT + F11", "Force full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

-- Applications & Menus
o.bind("SUPER + B", "Browser", "omarchy-launch-browser")
o.bind("SUPER + SHIFT + B", "Browser (private)", "omarchy-launch-browser --private")
o.bind("SUPER + D", "Apps menu", "omarchy-menu toggle apps")
o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle")
o.bind("SUPER + E", "File manager", "uwsm app -- nautilus --new-window")
o.bind("SUPER + M", "Music", "omarchy-launch-or-focus cider")
o.bind("SUPER + N", "Editor", "omarchy-launch-editor")
o.bind(
	"SUPER + O",
	"Obsidian",
	'omarchy-launch-or-focus obsidian "uwsm app -- obsidian -disable-gpu --enable-wayland-ime"'
)
o.bind("SUPER + slash", "Passwords", "omarchy-launch-or-focus bitwarden-desktop")
o.bind("SUPER + SHIFT + S", "Screenshot", "omarchy-capture-screenshot smart copy")
o.bind("SUPER + CTRL + K", "Keybindings menu", "omarchy-menu keybindings")

-- Web Apps
o.bind("SUPER + A", "ChatGPT", 'omarchy-launch-webapp "https://chatgpt.com"')
o.bind("SUPER + SHIFT + A", "Grok", 'omarchy-launch-webapp "https://grok.com"')
o.bind("SUPER + Y", "YouTube", 'omarchy-launch-or-focus-webapp YouTube "https://youtube.com/"')
o.bind("SUPER + SHIFT + G", "WhatsApp", 'omarchy-launch-or-focus-webapp WhatsApp "https://web.whatsapp.com/"')
o.bind(
	"SUPER + ALT + G",
	"Google Messages",
	'omarchy-launch-or-focus-webapp "Google Messages" "https://messages.google.com/web/conversations"'
)

-- Scratchpad
o.bind("SUPER + S", "Toggle scratchpad", hl.dsp.workspace.toggle_special("scratchpad"))
o.bind(
	"SUPER + ALT + S",
	"Move to scratchpad",
	hl.dsp.window.move({ workspace = "special:scratchpad", follow = false })
)

-- Vim Window Navigation
o.bind("SUPER + H", "Focus left", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + J", "Focus down", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + K", "Focus up", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + L", "Focus right", hl.dsp.focus({ direction = "r" }))

o.bind("SUPER + SHIFT + H", "Swap left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + SHIFT + J", "Swap down", hl.dsp.window.swap({ direction = "d" }))
o.bind("SUPER + SHIFT + K", "Swap up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + SHIFT + L", "Swap right", hl.dsp.window.swap({ direction = "r" }))

-- Zoom bindings
hl.unbind("SUPER + Z")
hl.unbind("SUPER + CTRL + Z")
hl.unbind("SUPER + CTRL + ALT + Z")

o.bind("SUPER + Z", "Zoom in", function()
	local zoom = hl.get_config("cursor.zoom_factor") or 1
	hl.config({ cursor = { zoom_factor = zoom + 1 } })
end)
o.bind("SUPER + CTRL + Z", "Reset zoom", function()
	hl.config({ cursor = { zoom_factor = 1 } })
end)

-- Workspaces 1-10 on HDMI-A-1
for i = 1, 10 do
	local key = "code:" .. tostring(i + 9)
	local num = tostring(i % 10)
	hl.unbind("SUPER + " .. key)
	hl.unbind("SUPER + SHIFT + " .. key)
	hl.unbind("SUPER + " .. num)
	hl.unbind("SUPER + SHIFT + " .. num)

	o.bind("SUPER + " .. key, "Switch to workspace " .. i, hl.dsp.focus({ workspace = tostring(i), release = false }))
	o.bind(
		"SUPER + SHIFT + " .. key,
		"Move to workspace " .. i,
		(hl.dsp.window.move({ workspace = tostring(i), follow = false, release = false }))
	)
end

-- Workspaces 11-20 on DP-1
for i = 1, 10 do
	local ws = i + 10
	local key = "code:" .. tostring(i + 9)
	local num = tostring(i % 10)
	hl.unbind("ALT + " .. key)
	hl.unbind("ALT + SHIFT + " .. key)
	hl.unbind("ALT + " .. num)
	hl.unbind("ALT + SHIFT + " .. num)

	o.bind("ALT + " .. key, "Switch to workspace " .. ws, hl.dsp.focus({ workspace = tostring(ws), release = false }))
	o.bind(
		"ALT + SHIFT + " .. key,
		"Move to workspace " .. ws,
		(hl.dsp.window.move({ workspace = tostring(ws), follow = false, release = false }))
	)
end

-- Universal Copy/Paste (CTRL+SHIFT+C / CTRL+SHIFT+V)
local function send_shortcut_once(mods, key)
	return function()
		hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down" }))
		hl.timer(function()
			hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up" }))
		end, { timeout = 50, type = "oneshot" })
	end
end

local function active_window_is_terminal()
	local window = hl.get_active_window()
	if not window then
		return false
	end
	for _, tag in ipairs(window.tags or {}) do
		if tag:gsub("%*$", "") == "terminal" then
			return true
		end
	end
	return false
end

local function universal_clipboard(def_mods, def_key, term_mods, term_key)
	return function()
		if active_window_is_terminal() then
			send_shortcut_once(term_mods, term_key)()
		else
			send_shortcut_once(def_mods, def_key)()
		end
	end
end

o.bind("CTRL + SHIFT + C", "Universal copy", universal_clipboard("CTRL", "C", "CTRL", "Insert"))
o.bind("CTRL + SHIFT + V", "Universal paste", universal_clipboard("CTRL", "V", "SHIFT", "Insert"))
