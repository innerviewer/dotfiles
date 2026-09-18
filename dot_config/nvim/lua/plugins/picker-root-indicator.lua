return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    opts.picker = opts.picker or {}
    opts.picker.actions = opts.picker.actions or {}

    local function root_label(p)
      local root = LazyVim.root({ buf = p.input.filter.current_buf, normalize = true })
      local cwd = vim.fs.normalize(p:cwd())
      return cwd == root and " [ROOT]" or " [CWD]"
    end

    opts.picker.on_show = function(p)
      vim.schedule(function()
        if p.closed then
          return
        end
        local title = p.title .. root_label(p)
        if p.layout and p.layout.root then
          p.layout.root:set_title({ { " " .. title .. " ", "FloatTitle" } })
        end
      end)
    end

    opts.picker.actions.toggle_cwd = function(p)
      local root = LazyVim.root({ buf = p.input.filter.current_buf, normalize = true })
      local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
      local current = p:cwd()
      p:set_cwd(current == root and cwd or root)
      p:find()
      local title = p.title .. root_label(p)
      if p.layout and p.layout.root then
        p.layout.root:set_title({ { " " .. title .. " ", "FloatTitle" } })
      end
    end
  end,
}
