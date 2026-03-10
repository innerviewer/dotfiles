return {
  "Civitasv/cmake-tools.nvim",
  lazy = true,
  enabled = function()
    return require("config.cmake_tools_project").is_cmake_project()
  end,
  opts = {
    on_build_dir_changed = function(_)
      vim.cmd("LspRestart")
    end,
    cmake_kits_path = "~/.config/nvim/cmake-kits.json",
    cmake_build_args = { "-j 16" },

    -- cmake-tools defaults to `runInTerminal = true`, which can result in the program
    -- running outside the debugger (no threads/stack frames to control).
    cmake_dap_configuration = {
      type = "codelldb",
      request = "launch",
      runInTerminal = false,
      console = "internalConsole",
    },
  },

  cmd = {
    "CMakeQuickStart",
    "CMakeGenerate",
    "CMakeBuild",
    "CMakeRun",
    "CMakeDebug",
    "CMakeSelectKit",
    "CMakeSelectBuildType",
    "CMakeSelectBuildTarget",
    "CMakeShowBuildMenu",
  },

  config = function(_, opts)
    require("cmake-tools").setup(opts)
  end,
}
