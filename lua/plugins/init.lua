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


---------------------------------
-- Plugins Installation
---------------------------------
return require("packer").startup(function()
  -- packer itself
  use 'wbthomason/packer.nvim'
  -- file manager
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
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
  -- which-key
  use {
    'folke/which-key.nvim',
    config = [[ require('config.whichkey') ]]
  }

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
  -- Beta
  -----------
  -- all the plugins that are under beta (from my perspective) will reside here
  -- if no adverse effect found then it will move to plugins
  -- startup time
  use {
    'henriquehbr/nvim-startup.lua',
    config = [[ require('nvim-startup') ]]
  }
end)