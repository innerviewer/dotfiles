return {
  -- Core Dadbod
  {
    "tpope/vim-dadbod",
    cmd = { "DB" },
  },

  -- UI
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "tpope/vim-dadbod",
      "kristijanhusak/vim-dadbod-completion",
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection" },
    init = function()
      -- Optional UI settings
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },

  -- Completion
  {
    "kristijanhusak/vim-dadbod-completion",
    ft = { "sql", "mysql", "plsql" },
  },
}
