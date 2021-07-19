local opt = vim.opt
local cmd = vim.cmd
local G = vim.g

opt.relativenumber = true
opt.updatetime = 100
opt.termguicolors = true

cmd([[
	augroup SpellEnable
	  autocmd!
	  autocmd FileType markdown setlocal spell
	  autocmd FileType gitcommit setlocal spell
	augroup END
]])

-- nvim-tree config
G.nvim_tree_ignore = { '.git', '.mypy_cache', '__pycache__', '.vscode' }
G.nvim_tree_auto_close = 1

-- dashboard config
G.dashboard_default_executive = 'telescope'

-- indent line
-- G.indent_blankline_space_char = '.'
G.indent_blankline_use_treesitter = true
G.indent_blankline_show_current_context = true
G.indent_blankline_filetype_exclude = { 'help', 'dashboard', 'NvimTree', 'packer' }
