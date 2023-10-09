return {

  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@type lspconfig.options
      servers = {
        taplo = {}, -- toml
        bashls = {}, -- bash, sh
        pyright = {}, -- python
        ruff_lsp = {}, -- python
      },
    },
    setup = {
      ruff_lsp = function()
        require("lazyvim.util").on_attach(function(client, _)
          if client.name == "ruff_lsp" then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end
        end)
      end,
    },
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      ---@diagnostic disable: missing-parameter
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, {
        -- bash
        "shellcheck",
        "shfmt",

        -- toml
        "taplo",
      })
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      -- toml
      table.insert(opts.sources, nls.builtins.formatting.taplo)

      -- bash
      table.insert(opts.sources, nls.builtins.diagnostics.shellcheck)
      table.insert(opts.sources, nls.builtins.formatting.shfmt)

      -- python
      table.insert(opts.sources, nls.builtins.diagnostics.mypy)

      table.insert(opts.sources, nls.builtins.formatting.black)
      table.insert(opts.sources, nls.builtins.formatting.isort)
    end,
  },
}
