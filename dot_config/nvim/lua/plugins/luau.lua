return {
  {
    "lopi-py/luau-lsp.nvim",
    opts = {
      platform = {
        type = "roblox",
      },

      types = {
        roblox_security_level = "PluginSecurity",
      },

      sourcemap = {
        enabled = true,
        autogenerate = true,
        rojo_path = "rojo",
        rojo_project_file = "default.project.json",
        include_non_scripts = true,
        sourcemap_file = "sourcemap.json",
      },
    },
  },
}
