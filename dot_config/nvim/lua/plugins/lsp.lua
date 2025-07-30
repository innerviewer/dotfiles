return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      cmake = {
        keys = {
          { "<leader>ccg", "<cmd>CMakeGenerate<cr>", desc = "CMake Generate" },
          { "<leader>ccb", "<cmd>CMakeBuild<cr>", desc = "CMake Build" },
          { "<leader>ccr", "<cmd>CMakeRun<cr>", desc = "CMake Run" },
          { "<leader>ccd", "<cmd>CMakeDebug<cr>", desc = "CMake Debug" },
          { "<leader>cck", "<cmd>CMakeSelectKit<cr>", desc = "CMake Select Toolchain" },
          { "<leader>ccs", "<cmd>CMakeSelectBuildType<cr>", desc = "CMake Select Build Type" },
          { "<leader>cct", "<cmd>CMakeSelectBuildTarget<cr>", desc = "CMake Select Target" },
          { "<leader>ccm", "<cmd>CMakeShowBuildMenu<cr>", desc = "CMake Show Build Menu" },
        },
      },

      clangd = {
        keys = {
          { "<leader>ccg", "<cmd>CMakeGenerate<cr>", desc = "CMake Generate" },
          { "<leader>ccb", "<cmd>CMakeBuild<cr>", desc = "CMake Build" },
          { "<leader>ccr", "<cmd>CMakeRun<cr>", desc = "CMake Run" },
          { "<leader>ccd", "<cmd>CMakeDebug<cr>", desc = "CMake Debug" },
          { "<leader>cck", "<cmd>CMakeSelectKit<cr>", desc = "CMake Select Toolchain" },
          { "<leader>ccs", "<cmd>CMakeSelectBuildType<cr>", desc = "CMake Select Build Type" },
          { "<leader>cct", "<cmd>CMakeSelectBuildTarget<cr>", desc = "CMake Select Target" },
          { "<leader>ccm", "<cmd>CMakeShowBuildMenu<cr>", desc = "CMake Show Build Menu" },
        },
      },
    },
    setup = {
      clangd = function()
        local cmake = require("cmake-tools")
        require("lspconfig").clangd.setup({
          cmd = function()
            local build_dir = cmake.get_build_directory()
            return { "clangd", "--compile-commands-dir=" .. build_dir }
          end,

          on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
          end,
        })
      end,
    },
  },
}
