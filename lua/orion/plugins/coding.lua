return {
  "tpope/vim-surround",
  "tpope/vim-sleuth",
  "tpope/vim-repeat",

  -- git plugins
  "tpope/vim-fugitive",
  "lewis6991/gitsigns.nvim",

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
  "folke/zen-mode.nvim",

  -- python
  {
    -- "numiras/semshi",
    "wookayin/semshi", -- use a maintained fork
    ft = "python",
    build = ":UpdateRemotePlugins",
    init = function()
      -- Disabled these features better provided by LSP or other more general plugins
      vim.g["semshi#error_sign"] = false
      vim.g["semshi#simplify_markup"] = false
      vim.g["semshi#mark_selected_nodes"] = false
      vim.g["semshi#update_delay_factor"] = 0.001

      -- This autocmd must be defined in init to take effect
      vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
        group = vim.api.nvim_create_augroup("SemanticHighlight", {}),
        callback = function()
          -- Only add style, inherit or link to the LSP's colors
          vim.cmd([[
            highlight! link semshiGlobal          @none
            highlight! link semshiImported        @none
            highlight! link semshiParameter       @lsp.type.parameter
            highlight! link semshiBuiltin         @function.builtin
            highlight! link semshiAttribute       @field
            highlight! link semshiSelf            @lsp.type.selfKeyword
            highlight! link semshiUnresolved      @none
            highlight! link semshiFree            @none
            highlight! link semshiAttribute       @none
            highlight! link semshiParameterUnused @none
            ]])
        end,
      })
    end,
  },
}
