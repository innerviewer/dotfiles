-- Require cmake-tools
local cmake = require("cmake-tools")

-- Setup clangd with dynamic compile-commands-dir
require("lspconfig").clangd.setup({
  cmd = function()
    -- Always use the latest build directory from cmake-tools
    local build_dir = cmake.get_build_directory()
    return { "clangd", "--compile-commands-dir=" .. build_dir }
  end,
  -- Add any other clangd options you need here
})

-- Setup cmake-tools with a callback to restart clangd on build directory change
require("cmake-tools").setup({
  on_build_dir_changed = function(_)
    -- This will restart all LSPs, including clangd, so the new cmd is used
    vim.cmd("LspRestart")
  end,
})
