return require('packer').startup(function()
	-- selfcare
	use 'wbthomason/packer.nvim'

	-- appearance
	use {
		'navarasu/onedark.nvim',
		'projekt0n/github-nvim-theme',
		'folke/tokyonight.nvim',
		'shaunsingh/solarized.nvim',
	}
	use {
		'hoob3rt/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}

	-- programming/tools
	--** treesitter
	use {
		{
			'nvim-treesitter/nvim-treesitter',
			run = ':TSUpdate'
		},
		{
			'nvim-treesitter/nvim-treesitter-textobjects',
			event = 'BufReadPost',
		},
		{
			'JoosepAlviste/nvim-ts-context-commentstring',
			event = 'BufReadPost',
		},
		{
			'RRethy/nvim-treesitter-textsubjects',
			event = 'BufReadPost',
		},
		{
			'p00f/nvim-ts-rainbow',
			event = 'BufReadPost'
		},
	}
	--** indent
	use {
		'lukas-reineke/indent-blankline.nvim',
		event = "BufReadPost"
	}
	--** git 
	use {
		'tpope/vim-fugitive',
		opt = true,
		cmd = { 'Git' }
	}
	use {
		'lewis6991/gitsigns.nvim',
		config = function ()
			require('gitsigns').setup()
		end,
		requires = {
			'nvim-lua/plenary.nvim'
		},
		event = 'BufWinEnter'
	}
	use {
		'sindrets/diffview.nvim',
		config = function()
			require('diffview').setup()
		end,
		event = 'BufWinEnter'
	}
	--** language
	use {
		'iamcco/markdown-preview.nvim',
		run = 'cd app && yarn install',
	}
	--** formating
	use {
		'mfussenegger/nvim-lint',
	}

	-- Filemanager
	--** telescope
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use {
		'nvim-telescope/telescope.nvim',
		config = function ()
			require('telescope').setup()
		end
	}
	--** nvim-tree
	use {
		'kyazdani42/nvim-tree.lua',
		requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}

	-- Tools
	--** whichkey
	use {
		'folke/which-key.nvim',
		config = function()
			require 'which-key-config'
		end,
		event = 'VimEnter'
	}
	--** Terminal
	use {
		'numtostr/FTerm.nvim',
		config = function()
			require("FTerm").setup()
		end,
		event = 'BufWinEnter'
	}
	--** zen mode
	use {
		'folke/zen-mode.nvim',
		config = function()
			require("zen-mode").setup()
		end,
		event = 'BufReadPost'
	}
	-- use {
	-- 	'folke/twilight.nvim',
	-- 	config = function()
	-- 		require("twilight").setup()
	-- 	end,
	-- }
	use {
		'folke/todo-comments.nvim',
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup()
		end,
		event = 'BufReadPost'
	}
	--** Dashboard
	use 'glepnir/dashboard-nvim'
	--** color
	use {
		'norcalli/nvim-colorizer.lua',
		config = function()
			require('colorizer').setup()
		end,
		event = "BufReadPost"
	}

	-- moving around
	use {
		{
			'justinmk/vim-sneak',
			event = 'BufReadPost'
		},
		{
			'tpope/vim-surround',
			event = 'BufReadPost'
		},
		{
			'tpope/vim-commentary',
			event = 'BufReadPost'
		},
		{
			'easymotion/vim-easymotion',
			event = 'BufReadPost'
		},
		{
			'terryma/vim-multiple-cursors',
			event = 'BufReadPost'
		},
		{
			'tpope/vim-repeat',
			event = 'BufReadPost'
		},
		{
			'andymass/vim-matchup',
			event = 'VimEnter'
		},
		{
			'windwp/nvim-autopairs',
			config = function ()
				require('nvim-autopairs').setup()
			end,
			event = 'BufWinEnter'
		},
	}
end)
