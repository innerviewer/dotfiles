return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      -- CodeLLDB adapter (required by cmake-tools.nvim :CMakeDebug)
      -- nvim-dap expects this adapter to be a server it can connect to.
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        host = "127.0.0.1",
        executable = {
          command = "codelldb", -- ensure this is in PATH
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }

      -- Use same config for C
      dap.configurations.c = dap.configurations.cpp
    end,
  },

  -- optional: nice UI for breakpoints, stacks, watches
  { "rcarriga/nvim-dap-ui", dependencies = "mfussenegger/nvim-dap" },

  -- optional: virtual text for showing variable values inline
  { "theHamsta/nvim-dap-virtual-text", dependencies = "mfussenegger/nvim-dap" },
}
