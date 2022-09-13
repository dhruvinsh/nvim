-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
M.plugins = {
  ["folke/which-key.nvim"] = {
      disable = false,
  },
  ["max397574/better-escape.nvim"] = {
      event = "InsertEnter",
      config = function()
          require("better_escape").setup()
      end,
  },
  ["TimUntersberger/neogit"] = {
      cmd = require("custom.lazy_load").neogit_cmds,
      requires = "nvim-lua/plenary.nvim",
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
       require "custom.plugins.null-ls"
    end,
  },
  ["williamboman/mason.nvim"] = {
    override_options = {
      ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",

        -- python
        "pyright",

        -- web dev
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "json-lsp",

        -- shell
        "shfmt",
        "shellcheck",
      },
    },
  },
}

M.mappings = require "custom.mappings"

return M
