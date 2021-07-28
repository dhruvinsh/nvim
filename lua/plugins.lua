-- Install packer
local packer = require("util.packer")

local config = {
  profile = {
    enable = true,
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
}

local function plugins(use)
  use ({'wbthomason/packer.nvim', opt=true}) -- Package manager
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use({
      "b3nj5m1n/kommentary",
      opt = true,
      wants = "nvim-ts-context-commentstring",
      keys = { "gc", "gcc" },
      config = function()
        require("config.comments")
      end,
      requires = "JoosepAlviste/nvim-ts-context-commentstring",
  })
  -- use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } } }
  use ({'navarasu/onedark.nvim',
	config=[[ require('onedark').setup() ]],
  }) -- Theme inspired by Atom
  use ({'hoob3rt/lualine.nvim',
  event = "VimEnter",
  config = [[ require('config.lualine') ]],
  requires = {'kyazdani42/nvim-web-devicons', opt = true}
}) -- Fancier statusline
  -- Add indentation guides even on blank lines
  use ({'lukas-reineke/indent-blankline.nvim',
	  event="BufReadPre",
	  config = [[ require('config.blankline') ]],
  })
  -- Add git related info in the signs columns and popups
  use({
      "lewis6991/gitsigns.nvim",
      event = "BufReadPre",
      wants = "plenary.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = [[ require("config.gitsigns") ]],
  })
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    opt = true,
    event = "BufRead",
    requires = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "RRethy/nvim-treesitter-textsubjects",
    },
    config = [[require('config.treesitter')]],
  })
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-compe' -- Autocompletion plugin
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
end

return packer.setup(config, plugins)
