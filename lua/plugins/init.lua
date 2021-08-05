---------------------------------
-- Packer Bootstraping
---------------------------------
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
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
  use 'wbthomason/packer.nvim'
  -- file manager
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  -----------
  -- Git
  -----------
  use {
    'lewis6991/gitsigns.nvim',
    event = "BufReadPre",
    config = [[ require('config.gitsigns') ]],
    requires = { 'nvim-lua/plenary.nvim' }
  }

  -----------
  -- UI
  -----------
  -- theme(s)
  use {
    'navarasu/onedark.nvim',
    config = [[ require('config.theme') ]]
  }
  -- status line
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = [[ require('config.statusline') ]]
  }
  -- indent lines
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = [[ require('config.indentline') ]],
  }
  -- which-key
  use {
    'folke/which-key.nvim',
    config = [[ require('config.whichkey') ]]
  }

  ---------------
  -- Programming
  ---------------
  -- incremental parser
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = [[ require('config.treesitter') ]],
    requires = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    }
  }

  -----------
  -- LSP
  -----------
  use {
    'neovim/nvim-lspconfig',
    config = [[ require('config.lsp') ]],
    requires = {
      {
        'simrat39/symbols-outline.nvim',
	cmd = { 'SymbolsOutline' },
      },
    }
  }
  use {
    'hrsh7th/nvim-compe',
    config = [[ require('config.lsp.compe') ]],
  }
  use {
    'L3MON4D3/LuaSnip',
    config = [[ require('config.lsp.snip') ]],
    requires={'rafamadriz/friendly-snippets'},
  }
  use {
    'kabouzeid/nvim-lspinstall',
  }

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
