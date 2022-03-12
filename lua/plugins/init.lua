---------------------------------
-- Packer Bootstraping
---------------------------------
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  execute("packadd packer.nvim")
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd FileType lua autocmd BufWritePost $HOME/.config/nvim/* PackerCompile
  augroup end
]],
  false
)

---------------------------------
-- Plugins Installation
---------------------------------
return require("packer").startup(function(use)
  -----------
  -- Tools
  -----------
  -- packer itself
  use("wbthomason/packer.nvim")
  -- file manager
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    config = [[ require('config.telescope') ]],
  })
  -- icons
  use({
    "kyazdani42/nvim-web-devicons",
    config = [[ require('config.icons') ]],
  })
  use({
    "kyazdani42/nvim-tree.lua",
    config = [[ require('config.nvimtree') ]],
  })
  -- tablines
  use({
    "akinsho/bufferline.nvim",
    config = [[ require('config.bufferline') ]],
    requires = "kyazdani42/nvim-web-devicons",
  })
  -- which-key
  use({
    "folke/which-key.nvim",
    config = [[ require('config.whichkey') ]],
  })
  -- repeat some commands
  use({
    "tpope/vim-repeat",
  })
  use({
    "npxbr/glow.nvim",
    run = "GlowInstall",
    ft = "markdown",
  })
  -- note taking app
  use({
    "nvim-neorg/neorg",
    ft = "norg",
    after = "nvim-treesitter",
    config = [[ require('config.neorg') ]],
    requires = { "nvim-lua/plenary.nvim" },
  })

  -----------
  -- Git
  -----------
  use({
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = [[ require('config.gitsigns') ]],
    requires = { "nvim-lua/plenary.nvim" },
  })
  use({
    "TimUntersberger/neogit",
    requires = { "nvim-lua/plenary.nvim" },
  })

  -----------
  -- UI
  -----------
  -- theme(s)
  use({
    "navarasu/onedark.nvim",
    config = [[ require('config.theme') ]],
  })
  -- status line
  use({
    "hoob3rt/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = [[ require('config.lualine') ]],
  })
  -- indent lines
  use({
    "lukas-reineke/indent-blankline.nvim",
    config = [[ require('config.indentline') ]],
  })
  -- todo
  use({
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = [[ require("config.todo") ]],
  })
  -- colorizer
  use({
    "norcalli/nvim-colorizer.lua",
    config = [[ require('colorizer').setup() ]],
  })
  -- color the brackets
  use({
    "p00f/nvim-ts-rainbow",
    config = [[ require('config.rainbow') ]],
  })

  -----------
  -- Editor
  -----------
  -- comment plugin
  use({
    "terrortylor/nvim-comment",
    config = [[ require('nvim_comment').setup() ]],
  })
  -- motion on lightspeed
  use({
    "ggandor/lightspeed.nvim",
    config = [[ require('config.lightspeed') ]],
  })
  -- autopairs
  use({
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = [[ require('config.autopairs') ]],
    requires = { "windwp/nvim-ts-autotag" },
  })
  -- zenmode
  use({
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = function()
      require("zen-mode").setup({
        plugins = { gitsigns = true, tmux = true },
      })
    end,
    requires = { "folke/twilight.nvim", opt = true },
  })

  ---------------
  -- Programming
  ---------------
  -- incremental parser
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = [[ require('config.treesitter') ]],
    requires = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  })

  -----------
  -- LSP
  -----------
  use({
    "neovim/nvim-lspconfig",
    config = [[ require('config.lsp') ]],
    requires = {
      {
        "simrat39/symbols-outline.nvim",
        cmd = { "SymbolsOutline" },
      },
    },
  })
  use({
    "hrsh7th/nvim-cmp",
    config = [[ require('config.lsp.cmp') ]],
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
  })
  use({
    "L3MON4D3/LuaSnip",
    config = [[ require('config.lsp.snip') ]],
    requires = { "rafamadriz/friendly-snippets" },
  })
  use({
    "williamboman/nvim-lsp-installer",
  })
  use({
    "ray-x/lsp_signature.nvim",
  })
  use({
    "kosayoda/nvim-lightbulb",
    config = [[ require('config.lightbulb') ]],
  })
  use({
    "folke/lsp-trouble.nvim",
    config = [[ require('config.trouble') ]],
  })

  -----------
  -- Beta
  -----------
  -- all the plugins that are under beta (from my perspective) will reside here
  -- if no adverse effect found then it will move to plugins
  -- startup time
  -- use {
  --   'henriquehbr/nvim-startup.lua',
  --   config = [[ require('nvim-startup') ]]
  -- }
end)
