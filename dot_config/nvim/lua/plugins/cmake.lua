return {
  "Civitasv/cmake-tools.nvim",
  opts = {
    on_build_dir_changed = function(_)
      vim.cmd("LspRestart")
    end,
    cmake_kits_path = "~/.config/nvim/cmake-kits.json",
    cmake_build_args = { "-j 16" },
  },

  keys = {
    { "<leader>cq", "<cmd>CMakeQuickStart<cr>", desc = "CMake Quick Start" },
  },

  config = function(_, opts)
    require("cmake-tools").setup(opts)
  end,
}
