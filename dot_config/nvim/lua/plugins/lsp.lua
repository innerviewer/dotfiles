return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      cmake = {
        -- CMake tools keymaps are defined globally in lua/plugins/cmake.lua
      },

      clangd = {
        keys = {
          { "gs", "<cmd>LspClangdSwitchSourceHeader<cr>", desc = "Jump between Source/Header." },
        },
      },
    },
    setup = {
      clangd = function()
        require("lspconfig").clangd.setup({
          on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
          end,
        })
      end,
    },
  },
}
