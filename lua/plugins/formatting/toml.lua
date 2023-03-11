return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "taplo",
      },
    },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      table.insert(opts.sources, nls.builtins.formatting.taplo)
    end,
  },
}
