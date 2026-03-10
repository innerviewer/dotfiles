local M = {}

local function find_cmakelists(start)
  local path = start or vim.uv.cwd()
  if vim.fs and vim.fs.find then
    local found = vim.fs.find("CMakeLists.txt", { path = path, upward = true, stop = vim.env.HOME })
    return found and found[1] or nil
  end

  local candidate = path .. "/CMakeLists.txt"
  if vim.uv.fs_stat(candidate) then
    return candidate
  end
  return nil
end

function M.is_cmake_project()
  return find_cmakelists(vim.uv.cwd()) ~= nil
end

function M.setup_cmake_tools_keymaps()
  local ok, lazy = pcall(require, "lazy")
  if not ok then
    return
  end

  if not M.is_cmake_project() then
    return
  end

  local function load()
    lazy.load({ plugins = { "cmake-tools.nvim" } })
  end

  local function load_and(cmd)
    return function()
      load()
      vim.cmd(cmd)
    end
  end

  local map = vim.keymap.set
  map("n", "<leader>cq", load_and("CMakeQuickStart"), { desc = "CMake Quick Start" })
  map("n", "<leader>ccg", load_and("CMakeGenerate"), { desc = "CMake Generate" })
  map("n", "<leader>ccb", load_and("CMakeBuild"), { desc = "CMake Build" })
  map("n", "<leader>ccr", load_and("CMakeRun"), { desc = "CMake Run" })
  map("n", "<leader>ccd", load_and("CMakeDebug"), { desc = "CMake Debug" })
  map("n", "<leader>cck", load_and("CMakeSelectKit"), { desc = "CMake Select Toolchain" })
  map("n", "<leader>ccs", load_and("CMakeSelectBuildType"), { desc = "CMake Select Build Type" })
  map("n", "<leader>cct", load_and("CMakeSelectBuildTarget"), { desc = "CMake Select Target" })
  map("n", "<leader>ccm", load_and("CMakeShowBuildMenu"), { desc = "CMake Show Build Menu" })
end

return M
