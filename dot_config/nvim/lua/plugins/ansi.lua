return {
  "m00qek/baleia.nvim",
  config = function()
    local baleia = require("baleia").setup({})
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dap-repl",
      callback = function(args)
        baleia.automatically(args.buf)
      end,
    })
  end,
}
