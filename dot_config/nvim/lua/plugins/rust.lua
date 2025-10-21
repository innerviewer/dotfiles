return {
  "mrcjkb/rustaceanvim",
  version = "^6", -- Recommended
  lazy = false, -- This plugin is already lazy
  server = {
    default_settings = {
      ["rust-analyzer"] = {
        check = {
          ignore = { "unused_imports", "dead_code", "unused_variables" },
        },
      },
    },
  },
}
