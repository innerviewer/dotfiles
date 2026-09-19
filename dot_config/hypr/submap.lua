-- ~/.config/hypr/custom/submap.lua
-- Submap definitions for temporary Alt-key passthrough

-- o.bind("SUPER + E", "Submap noalt", hl.dsp.submap("noalt"))

-- Submaps only capture keys explicitly bound inside them.
-- Unbound keys pass through automatically to the active window.
hl.define_submap("noalt", function()
  hl.bind("SHIFT + escape", hl.dsp.submap("reset"), { description = "Reset submap" })
end)
