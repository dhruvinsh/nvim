local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
  return
end

-- Available options for color pallets:
-- latte, frappe, macchiato, mocha
vim.g.catppuccin_flavour = "mocha"

catppuccin.setup({
  transparent_background = false,
  term_colors = false,
  compile = {
    enabled = false,
    path = vim.fn.stdpath("cache") .. "/catppuccin",
  },
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  integrations = {
    treesitter = true,
    cmp = true,
    gitsigns = true,
    telescope = true,
    nvimtree = true,
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
  color_overrides = {},
  highlight_overrides = {},
})
