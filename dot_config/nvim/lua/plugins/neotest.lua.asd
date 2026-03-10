return {
  "nvim-neotest/neotest",
  dependencies = {
    "rcasia/neotest-java",
    "andythigpen/nvim-coverage",
    "nvim-lua/plenary.nvim",
  },
  opts = {
    adapters = {
      require("neotest-java")({
        -- Optional: specify Maven command
        -- command = "mvn test",
      }),
    },
    -- Keymaps in LazyVim style
    keys = {
      {
        "<leader>tn",
        function()
          require("neotest").run.run()
        end,
        desc = "Run nearest test",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.getcwd())
        end,
        desc = "Run all tests",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle test summary",
      },
      {
        "<leader>to",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Toggle test output panel",
      },
      {
        "<leader>tc",
        function()
          require("coverage").load(true)
        end,
        desc = "Load coverage",
      },
    },
  },
  config = function(_, opts)
    require("neotest").setup(opts)

    require("coverage").setup({
      auto_reload = true,
      highlights = {
        covered = "DiffAdd",
        uncovered = "DiffDelete",
        partially_covered = "DiffChange",
      },
    })
  end,
}
