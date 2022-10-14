local colorscheme = "catppuccin"

-- Check for colorscheme configuration, if available or not
pcall(require, "orion.colorscheme.config." .. colorscheme)

-- Check if the colorscheme is found
pcall(vim.api.nvim_cmd, {
  cmd = "colorscheme",
  args = { colorscheme },
}, {}) -- empty {} required as part of opts, https://www.reddit.com/r/neovim/comments/uncloj/comment/i888uly/?utm_source=share&utm_medium=web2x&context=3
