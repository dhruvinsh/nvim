return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@type lspconfig.options
      servers = {
        pyright = {},
        ruff_lsp = {},
      },
    },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")

      table.insert(opts.sources, nls.builtins.diagnostics.mypy)

      table.insert(opts.sources, nls.builtins.formatting.black)
      table.insert(opts.sources, nls.builtins.formatting.isort)
    end,
  },
}
