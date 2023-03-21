return {
  {
    "williamboman/mason.nvim",
    ---@diagnostic disable: missing-parameter
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "taplo" })
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      table.insert(opts.sources, nls.builtins.formatting.taplo)
    end,
  },
}
