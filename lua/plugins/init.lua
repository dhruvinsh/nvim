local plugins = {
  -- Some core packages that I need it no matter what kind of setup it is
  ["wbthomason/packer.nvim"] = { config = [[ require("plugins") ]] },
  ["lewis6991/impatient.nvim"] = {},
  ["kyazdani42/nvim-web-devicons"] = {},
  ["kevinhwang91/promise-async"] = {},
  ["nvim-lua/plenary.nvim"] = {},
  ["tami5/sqlite.lua"] = {},

  -- Code highligting
  ["nvim-treesitter/nvim-treesitter"] = { config = [[require("plugins.config.treesitter") ]] },
  ["nvim-treesitter/nvim-treesitter-context"] = { config = [[require("plugins.config.treesitter-context") ]] },
  ["nvim-treesitter/nvim-treesitter-textobjects"] = {},

  -- LSP setup
  ["neovim/nvim-lspconfig"] = {},
  ["williamboman/mason.nvim"] = {},
  ["williamboman/mason-lspconfig.nvim"] = {},
  ---- LSP completion
  ["hrsh7th/nvim-cmp"] = {},
  ["hrsh7th/cmp-buffer"] = {},
  ["hrsh7th/cmp-nvim-lsp"] = {},
  ["hrsh7th/cmp-nvim-lua"] = {},
  ["hrsh7th/cmp-path"] = {},
  ---- LSP nice icons
  ["onsails/lspkind.nvim"] = {},
  ---- LSP snippet
  ["L3MON4D3/LuaSnip"] = {},
  ["rafamadriz/friendly-snippets"] = {},
  ["saadparwaiz1/cmp_luasnip"] = {},
  ---- LSP code formatting
  ["jose-elias-alvarez/null-ls.nvim"] = { config = [[require("plugins.config.null-ls") ]] },
  ---- LSP code highligting
  ["RRethy/vim-illuminate"] = { config = [[require("plugins.config.illuminate") ]] },

  -- Fuzzy Finder
  ["nvim-telescope/telescope.nvim"] = { config = [[require("plugins.config.telescope") ]] },
  ["nvim-telescope/telescope-file-browser.nvim"] = {},
  ["nvim-telescope/telescope-frecency.nvim"] = {},
  ["nvim-telescope/telescope-fzf-native.nvim"] = {},
  ["nvim-telescope/telescope-smart-history.nvim"] = {},

  -- Git
  ["TimUntersberger/neogit"] = { config = [[require("plugins.config.neogit") ]] },
  ["lewis6991/gitsigns.nvim"] = { config = [[require("plugins.config.gitsigns") ]] },
  ["sindrets/diffview.nvim"] = { config = [[require("plugins.config.diffview") ]] },

  -- Programming
  ["chaoren/vim-wordmotion"] = {},
  ["danymat/neogen"] = { config = [[require("plugins.config.gitsigns") ]] },
  ["ggandor/flit.nvim"] = { config = [[require("plugins.config.flit") ]] },
  ["ggandor/leap.nvim"] = { config = [[require("plugins.config.leap") ]] },
  ["kevinhwang91/nvim-ufo"] = { config = [[require("plugins.config.ufo") ]] },
  ["kylechui/nvim-surround"] = { config = [[require("plugins.config.surround") ]] },
  ["max397574/better-escape.nvim"] = { config = [[require("plugins.config.better-escape") ]] },
  ["numToStr/Comment.nvim"] = { config = [[require("plugins.config.comment") ]] },
  ["stevearc/aerial.nvim"] = { config = [[require("plugins.config.aerial") ]] },
  ["tpope/vim-repeat"] = {},
  ["windwp/nvim-autopairs"] = { config = [[require("plugins.config.autopairs") ]] },
  ["Darazaki/indent-o-matic"] = { config = [[require("plugins.config.indent-o-matic") ]] },
  ---- Language specific
  ["folke/lua-dev.nvim"] = {},
  ["ellisonleao/glow.nvim"] = { ft = "markdown" },
  ["nvim-orgmode/orgmode"] = { config = [[require("plugins.config.orgmode") ]] },
  ---- Project management
  ["ahmedkhalf/project.nvim"] = { config = [[require("plugins.config.project") ]] },

  -- UI
  ---- Buffer management
  ["akinsho/bufferline.nvim"] = { config = [[require("plugins.config.bufferline") ]] },
  ---- Colorscheme
  ["catppuccin/nvim"] = {},
  ["ellisonleao/gruvbox.nvim"] = {},
  ["navarasu/onedark.nvim"] = {},
  ["shaunsingh/nord.nvim"] = {},
  ---- Dashboard
  --["goolord/alpha-nvim"] = { config = [[require("plugins.config.alpha") ]] },
  ---- Highlighting
  ["folke/todo-comments.nvim"] = { config = [[require("plugins.config.todo-comments") ]] },
  ---- Indentation
  ["lukas-reineke/indent-blankline.nvim"] = { config = [[require("plugins.config.indent-blankline") ]] },
  ---- Prductivity
  ["Pocco81/true-zen.nvim"] = { config = [[require("plugins.config.true-zen") ]] },
  ---- Statusline
  ["nvim-lualine/lualine.nvim"] = { config = [[require("plugins.config.lualine") ]] },

  -- Tool
  ["Pocco81/auto-save.nvim"] = { config = [[require("plugins.config.auto-save") ]] },
  ["Shatur/neovim-session-manager"] = { config = [[require("plugins.config.session") ]] },
  ["akinsho/toggleterm.nvim"] = { config = [[require("plugins.config.toggleterm") ]] },
  ["folke/which-key.nvim"] = { config = [[require("plugins.config.which-key") ]] },
  ["kyazdani42/nvim-tree.lua"] = { config = [[require("plugins.config.nvim-tree") ]] },
  ["mrjones2014/tldr.nvim"] = { config = [[require("plugins.config.tldr") ]] },
}

-- Load the plugins
local status_ok, packer = pcall(require, "packer")

if status_ok then
  vim.cmd([[packadd packer.nvim]])
  local packer_init = require("plugins.config.packer")
  packer.init(packer_init)

  for key, plugin in pairs(plugins) do
    if type(key) == "string" and not plugin[1] then
      plugin[1] = key
    end
    packer.use(plugin)
  end
end
