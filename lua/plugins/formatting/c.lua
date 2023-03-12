return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clang-format",
      },
    },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      table.insert(opts.sources, nls.builtins.formatting.clang_format)
    end,
  },
}
