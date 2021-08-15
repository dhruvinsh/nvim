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
  -- repeat some commands
  use({
    "tpope/vim-repeat",
  })
  -- auto session managment
  use({
    "rmagatti/auto-session",
    requires = { "rmagatti/session-lens" },
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
    config = [[ require('config.statusline') ]],
  })
  -- dashboards
  use({
    "glepnir/dashboard-nvim",
    config = [[ require('config.dashboard') ]],
  })
  -- specs
  use({
    "edluffy/specs.nvim",
    config = [[ require('config.specs') ]],
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
  -- which-key
  use({
    "folke/which-key.nvim",
    config = [[ require('config.whichkey') ]],
  })
  -- colorizer
  use({
    "norcalli/nvim-colorizer.lua",
    config = [[ require('colorizer').setup() ]],
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
    config = [[ require('config.motion') ]],
  })
  -- autopairs
  use({
    "windwp/nvim-autopairs",
    after = "nvim-compe",
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
    "hrsh7th/nvim-compe",
    config = [[ require('config.lsp.compe') ]],
  })
  use({
    "L3MON4D3/LuaSnip",
    config = [[ require('config.lsp.snip') ]],
    requires = { "rafamadriz/friendly-snippets" },
  })
  use({
    "kabouzeid/nvim-lspinstall",
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
