return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      dap.set_log_level("DEBUG")

      vim.keymap.set("n", "<leader>dx", function()
        require("dapui").close()
        require("dap").terminate()
      end, { desc = "Close debug UI & terminate session" })

      vim.keymap.set("n", "<leader>dR", function()
        require("dap.repl").toggle()
      end, { desc = "Toggle Debug REPL" })

      -- CodeLLDB adapter (required by cmake-tools.nvim :CMakeDebug)
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        host = "127.0.0.1",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        },
      }
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    opts = {
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            { id = "console", size = 1.0 },
          },
          size = 15,
          position = "bottom",
        },
      },
    },
  },

  -- optional: virtual text for showing variable values inline
  { "theHamsta/nvim-dap-virtual-text", dependencies = "mfussenegger/nvim-dap" },
}
