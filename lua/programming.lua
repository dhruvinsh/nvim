local c = require('onedark.colors')

require('nvim-treesitter.configs').setup {
	ensure_installed = "maintained",
	ignore_install = { "ruby" , "java" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
		disable = { "latex" },
	},
	indent = {
		enable = true,
	},
	matchup = {
		enable = true,
		diable = { "ruby", "java" },
	},
	context_commentstring = {
		enable = true
	},
	autopairs = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			}
		}
	},
	textsubjects = {
		enable = true,
		keymaps = {
			['.'] = 'textsubjects-smart',
			[';'] = 'textsubjects-container-outer',
		}
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = 500,
		colors = {
			c.bg_blue,
			c.purple,
			c.yellow,
			c.cyan,
			c.orange,
			c.red,
		},
	},
}

require("lint").linters_by_ft = {
	python = {"pylint", "mypy"}
}
