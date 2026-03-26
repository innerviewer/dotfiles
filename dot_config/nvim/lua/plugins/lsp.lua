return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cmake = {
          -- CMake tools keymaps are defined globally in lua/plugins/cmake.lua
        },

        clangd = {
          keys = {
            { "gs", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Jump between Source/Header." },
          },
        },
      },
      setup = {
        clangd = function(_, opts)
          local ok, cmake = pcall(require, "cmake-tools")
          if ok then
            local build_dir = cmake.get_build_directory()
            if build_dir then
              opts.cmd = { "clangd", "--compile-commands-dir=" .. tostring(build_dir) }
            end

            -- Restart LSP when cmake build directory changes
            cmake.setup({
              on_build_dir_changed = function(_)
                vim.cmd("LspRestart")
              end,
            })
          end

          require("lspconfig").clangd.setup(opts)
          return true -- Skip LazyVim's default setup since we did it ourselves
        end,
      },
    },
  },

  -- Start clangd immediately on Neovim launch in C/C++ projects
  -- {
  --   "neovim/nvim-lspconfig",
  --   event = "VeryLazy",
  --   config = function()
  --     -- Check if this looks like a C/C++ project
  --     local root = vim.fn.getcwd()
  --     local markers = { "CMakeLists.txt", "compile_commands.json", "Makefile", ".clangd" }
  --     local is_c_project = false
  --     for _, marker in ipairs(markers) do
  --       if vim.fn.filereadable(root .. "/" .. marker) == 1 then
  --         is_c_project = true
  --         break
  --       end
  --     end
  --     if is_c_project then
  --       vim.cmd("LspStart clangd")
  --     end
  --   end,
  -- },

  -- Enable formatting for C/C++ using clang-format
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
      formatters = {
        ["clang-format"] = {
          prepend_args = { "--style=file:" .. vim.fn.expand("~/.config/nvim/.clang-format") },
        },
      },
    },
  },
}
