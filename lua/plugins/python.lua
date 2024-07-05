return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ninja", "python", "rst", "toml" })
      end
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {},
        ruff = {
          keys = {
            { "<leader>co", LazyVim.lsp.action["source.organizeImports"], desc = "Organize Imports" },
          },
        },
      },
      setup = {
        ["ruff_lsp"] = function()
          LazyVim.lsp.on_attach(function(client, _)
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end, "ruff")
        end,
      },
    },
  },

  {
    "mfussenegger/nvim-dap-python",
    -- stylua: ignore
    keys = {
      { "<leader>dPt", function() require("dap-python").test_method() end, desc = "Debug Method", ft = "python", },
      { "<leader>dPc", function() require("dap-python").test_class() end, desc = "Debug Class", ft = "python", },
    },
    config = function()
      local path = require("mason-registry").get_package("debugpy"):get_install_path()
      require("dap-python").setup(path .. "/venv/bin/python")
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.auto_brackets = opts.auto_brackets or {}
      table.insert(opts.auto_brackets, "python")
    end,
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = { "mypy" },
      },
    },
  },
}
