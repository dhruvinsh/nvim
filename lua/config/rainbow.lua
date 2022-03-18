local c = require("theme.onedark")

require("nvim-treesitter.configs").setup({
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    colors = {
      c.nord_blue,
      c.purple,
      c.yellow,
      c.cyan,
      c.orange,
      c.red,
    }, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
})
