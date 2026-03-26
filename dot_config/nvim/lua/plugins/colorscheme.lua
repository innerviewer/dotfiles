return {
  -- Keep tokyonight installed (LazyVim requires it) but override colorscheme below

  -- Tell LazyVim to use catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("nightfox") -- or "duskfox", "nordfox", "terafox", "carbonfox"
    end,
  },

  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("catppuccin").setup({
  --       flavour = "mocha",
  --       color_overrides = {
  --         mocha = {
  --           base = "#000000", -- Noir pur (Performance)
  --           mantle = "#000000",
  --           crust = "#000000",
  --           text = "#ffffff", -- Texte de base blanc
  --         },
  --       },
  --       highlight_overrides = {
  --         mocha = function()
  --           -- Bleu Saphir : Très lisible mais moins "néon"
  --           -- local variable_blue = "#89b4fa"
  --           local variable_blue = "#89b4fa"
  --           return {
  --             -- VARIABLES (LSP Semantic)
  --             ["@lsp.type.variable.c"] = { fg = variable_blue, style = { "bold" } },
  --             ["@lsp.mod.declaration.c"] = { fg = variable_blue, style = { "bold" } },
  --             ["@lsp.typemod.variable.definition.c"] = { fg = variable_blue, style = { "bold" } },
  --
  --             -- VARIABLES (Tree-sitter Fallback)
  --             ["@variable"] = { fg = variable_blue, style = { "bold" } },
  --             ["@variable.c"] = { fg = variable_blue, style = { "bold" } },
  --             ["Identifier"] = { fg = variable_blue },
  --
  --             -- PARAMÈTRES (argv, argc)
  --             ["@parameter"] = { fg = "#94e2d5", style = { "italic" } }, -- Vert d'eau discret
  --
  --             -- FONCTIONS : Lavande (plus sobre que l'orange ou le jaune)
  --             ["@function"] = { fg = "#cba6f7" },
  --             ["@function.call"] = { fg = "#cba6f7" },
  --
  --             -- MOTS-CLÉS : Rouge Doux (if, while, static)
  --             ["@keyword"] = { fg = "#f38ba8", style = { "bold" } },
  --
  --             -- FOND NOIR ABSOLU
  --             ["Normal"] = { bg = "#ffffff" },
  --           }
  --         end,
  --       },
  --     })
  --     vim.cmd.colorscheme("catppuccin")
  --   end,
  -- },
}
