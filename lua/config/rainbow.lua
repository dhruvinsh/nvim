local colors = require("config.colors")

require("nvim-treesitter.configs").setup({
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    colors = {
      colors.nord_blue,
      colors.purple,
      colors.yellow,
      colors.cyan,
      colors.orange,
      colors.red,
    }, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
})
