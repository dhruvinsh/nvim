require('onedark').setup()
-- require("solarized").set()

vim.g.solarized_borders = true

require('lualine').setup {
	icons_enables = true,
	options = {
		theme = 'onedark',
		-- theme = 'solarized',
		disabled_filetypes = { 'packer', 'dashboard' },
	},
	extensions = {'nvim-tree'}
}
