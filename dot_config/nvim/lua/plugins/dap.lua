return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      vim.keymap.set("n", "<leader>dx", function()
        require("dapui").close()
        require("dap").terminate()
      end, { desc = "Close debug UI & terminate session" })

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

  -- optional: nice UI for breakpoints, stacks, watches
  { "rcarriga/nvim-dap-ui", dependencies = "mfussenegger/nvim-dap" },

  -- optional: virtual text for showing variable values inline
  { "theHamsta/nvim-dap-virtual-text", dependencies = "mfussenegger/nvim-dap" },
}
