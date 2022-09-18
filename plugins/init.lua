local overrides = require("custom.plugins.overrides")
local lazyload = require("custom.plugins.lazy_load")

return {

  -- enable alpha-nvim
  ["goolord/alpha-nvim"] = { disable = false },

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

  ["NvChad/ui"] = {
    override_options = overrides.statusline,
  },

  ["nvim-telescope/telescope.nvim"] = {
    override_options = overrides.telescope,
  },

  -- installing some new plugins
  ["max397574/better-escape.nvim"] = {
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- project and file managment
  ["ahmedkhalf/project.nvim"] = {
    module = "telescope",
    config = function()
      require("project_nvim").setup({
        patterns = {
          ".git",
          "_darcs",
          ".hg",
          ".bzr",
          ".svn",
          "Makefile",
          "package.json",
          "pyproject.toml",
          "Pipfile",
        },
      })
    end,
  },

  ["Pocco81/auto-save.nvim"] = {
    event = "InsertEnter",
    config = function()
      require("auto-save").setup()
    end,
  },

  ["Pocco81/true-zen.nvim"] = {
    cmd = lazyload.truezen,
    config = function()
      require("true-zen").setup()
    end,
  },

  ["kylechui/nvim-surround"] = {
    event = "InsertEnter",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  ["ellisonleao/glow.nvim"] = {
    cmd = lazyload.glow,
    ft = "markdown",
  },

  -- some git tools
  ["TimUntersberger/neogit"] = {
    cmd = lazyload.neogit_cmds,
  },

  ["sindrets/diffview.nvim"] = {
    cmd = lazyload.diffview_cmds,
  },

  -- code formatting, linting etc
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("custom.plugins.null-ls")
    end,
  },

  -- languages
  ["nvim-orgmode/orgmode"] = {
    ft = "org",
    config = function()
      require("orgmode").setup_ts_grammar()
      require("orgmode").setup({
        org_agenda_files = { "~/Documents/org/*" },
        org_default_notes_file = "~/Documents/org/refile.org",
      })
    end,
  },
}
