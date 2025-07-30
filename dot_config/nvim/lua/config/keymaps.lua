-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<F5>", function() require("dap").continue() end, { desc = "Start/Continue Debugging" })
map("n", "<F7>", function() require("dap").step_over() end, { desc = "Step Over" })
map("n", "<F8>", function() require("dap").step_into() end, { desc = "Step Into" })
map("n", "<F9>", function() require("dap").step_out() end, { desc = "Step Out" })
map("n", "<Leader>ccp", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
map("n", "<Leader>ccB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Set Conditional Breakpoint" })
