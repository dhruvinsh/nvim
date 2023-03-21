return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      ---@diagnostic disable: missing-parameter
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, {
        -- as a part of standard dotfiles installation these packages are installed
        -- "mypy",
        -- "ruff",
        -- "black",
        -- "isort",
        "pyright",
      })

      -- remove flake8 from even downloading
      opts.ensure_installed = vim.tbl_filter(function(source)
        return source ~= "flake8"
      end, opts.ensure_installed)
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")

      table.insert(opts.sources, nls.builtins.diagnostics.mypy)
      table.insert(opts.sources, nls.builtins.diagnostics.ruff)

      table.insert(opts.sources, nls.builtins.formatting.black)
      table.insert(opts.sources, nls.builtins.formatting.isort)

      -- remove flake8 from opts.sources
      opts.sources = vim.tbl_filter(function(source)
        return source.name ~= "flake8"
      end, opts.sources)
    end,
  },
}
