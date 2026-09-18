-- ~/.config/hypr/custom/rules.lua
-- Custom window and workspace rules

hl.config({
  xwayland = {
    force_zero_scaling = true,
  },
})

hl.window_rule({ match = { workspace = "s[true]" }, no_screen_share = true })
o.window("^(SREngine)$", { float = true, center = true, size = "1500 1000" })
