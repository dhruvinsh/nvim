local overrides = require("custom.plugins.overrides")

return {

  -- enable which-key
  ["folke/which-key.nvim"] = { disable = false },

  -- some lsp changes
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require("plugins.configs.lspconfig")
      require("custom.plugins.lspconfig")
    end,
  },

  -- some config overrides
  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = overrides.treesitter,
  },

  ["williamboman/mason.nvim"] = {
    override_options = overrides.mason,
  },

  ["kyazdani42/nvim-tree.lua"] = {
    override_options = overrides.nvimtree,
  },

  -- installing some new plugins
  ["max397574/better-escape.nvim"] = {
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  ["TimUntersberger/neogit"] = {
    cmd = require("custom.lazy_load").neogit_cmds,
  },

  ["sindrets/diffview.nvim"] = {
    cmd = require("custom.lazy_load").diffview_cmds,
  },

  -- code formatting, linting etc
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("custom.plugins.null-ls")
    end,
  },
}
