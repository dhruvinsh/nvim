local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
  return
end

-- Available options for color pallets:
-- latte, frappe, macchiato, mocha
vim.g.catppuccin_flavour = "macchiato"

catppuccin.setup({
  transparent_background = false,
  term_colors = false,
  compile = {
    enabled = true,
    path = vim.fn.stdpath("cache") .. "/catppuccin",
  },
  dim_inactive = {
    enabled = false,
    shade = "light",
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
    aerial = true,
    cmp = true,
    fidget = true,
    gitsigns = true,
    illuminate = true,
    leap = true,
    lsp_trouble = true,
    markdown = true,
    neogit = true,
    nvimtree = true,
    telescope = true,
    treesitter = true,
    treesitter_context = true,
    ts_rainbow = true,
    which_key = true,

    -- Special integrations, see https://github.com/catppuccin/nvim#special-integrations
    dap = {
      enabled = false,
      enable_ui = false,
    },
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
  },
  color_overrides = {},
  highlight_overrides = {},
})

catppuccin.compile()
