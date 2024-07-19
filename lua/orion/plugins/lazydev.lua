return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    dependencies = { "Bilal2453/luvit-meta"},
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "Bilal2453/luvit-meta",
    lazy = true
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      vim.print(opts.sources)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0,
      })
    end,
  },
}
