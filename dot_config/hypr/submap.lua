-- ~/.config/hypr/custom/submap.lua
-- Submap definitions for temporary Alt-key passthrough

-- o.bind("SUPER + E", "Submap noalt", hl.dsp.submap("noalt"))

hl.define_submap("noalt", function()
  for i = 0, 9 do
    local key = tostring(i)
    hl.unbind("ALT + " .. key)
    hl.unbind("ALT + SHIFT + " .. key)
  end
  hl.bind("SHIFT + escape", hl.dsp.submap("reset"), { description = "Reset submap" })
end)
