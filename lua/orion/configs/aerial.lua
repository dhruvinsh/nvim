local status_ok, aerial = pcall(require, "aerial")

if not status_ok then
  return
end

aerial.setup({
  attach_mode = "global",
  backends = { "lsp", "treesitter" },
  min_width = 28,
  show_guides = true,
  filter_kind = false,
  guides = {
    mid_item = "├ ",
    last_item = "└ ",
    nested_top = "│ ",
    whitespace = "  ",
  },
})

-- if telescope loaded then load the aerial plugin as well.
pcall(require("telescope").load_extension, "aerial")
