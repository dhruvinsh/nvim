return {
  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    opts = {
      position = "right",
    },
  },

  -- Mason updates
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",
      },
    },
  },

  -- null-ls update
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, {
        -- python
        nls.builtins.diagnostics.mypy,
        nls.builtins.diagnostics.ruff,
        nls.builtins.formatting.black,
        nls.builtins.formatting.isort,

        -- shell
        nls.builtins.diagnostics.shellcheck,
        nls.builtins.formatting.shfmt,

        -- all other js based langs
        nls.builtins.formatting.prettier,
      })

      -- remove flake8 from opts.sources
      opts.sources = vim.tbl_filter(function(source)
        return source.name ~= "flake8"
      end, opts.sources)
    end,
  },
}
