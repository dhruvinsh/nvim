return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@type lspconfig.options
      servers = {
        bashls = {},
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      ---@diagnostic disable: missing-parameter
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, {
        "shellcheck",
        "shfmt",
      })
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      table.insert(opts.sources, nls.builtins.diagnostics.shellcheck)
      table.insert(opts.sources, nls.builtins.formatting.shfmt)
    end,
  },
}
