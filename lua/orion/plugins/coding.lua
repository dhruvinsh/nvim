return {
  "tpope/vim-surround",
  "tpope/vim-sleuth",
  "tpope/vim-repeat",

  -- git plugins
  "tpope/vim-fugitive",
  "lewis6991/gitsigns.nvim",

  { "numToStr/Comment.nvim", config = true },
  { "windwp/nvim-autopairs", opts = {} },

  -- tools
  "folke/trouble.nvim",
  "akinsho/toggleterm.nvim",

  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    "ellisonleao/glow.nvim",
    config = true,
    cmd = "Glow",
  },

  -- LSP Configuration & Plugins
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim",
      "j-hui/fidget.nvim",
    },
  },
  {
    -- "hrsh7th/nvim-cmp",  - switching to fork package for better support
    "dhruvinsh/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "petertriho/cmp-git",

      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },

  -- DAP Configuration
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      { "theHamsta/nvim-dap-virtual-text", opts = {} },
      "mfussenegger/nvim-dap-python",
    },
  },

  "folke/neoconf.nvim",
  "b0o/SchemaStore.nvim",
  "mfussenegger/nvim-lint",
  { "stevearc/conform.nvim", version = "*" },
  "RRethy/vim-illuminate",
  "folke/zen-mode.nvim",
}
