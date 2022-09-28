local status_ok, indent_blankline = pcall(require, "indent_blankline")

if status_ok then
  indent_blankline.setup({
    char = "┊",
    show_trailing_blankline_indent = false,
  })
end
