-- ~/.config/hypr/custom/input.lua
-- Custom keyboard, mouse, touchpad, and gesture settings

hl.config({
  input = {
    kb_layout = "us,ru",
    kb_options = "caps:escape,grp:alts_toggle",
    repeat_rate = 40,
    repeat_delay = 600,
    numlock_by_default = true,
    sensitivity = 0,
    accel_profile = "flat",
    touchpad = {
      natural_scroll = true,
      scroll_factor = 0.4,
    },
  },
  misc = {
    middle_click_paste = false,
  },
})

-- App-specific touchpad scroll rates
o.window("(Alacritty|kitty|foot)", { scroll_touchpad = 1.5 })
o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })

-- 3-finger horizontal gesture for workspaces
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
