local status_ok, aerial = pcall(require, "aerial")

if not status_ok then
  return
end

local legendary_status_ok, legendary = pcall(require, "legendary")

if not legendary_status_ok then
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
  on_attach = function(bufnr)
    legendary.bind_keymaps(require("plugins.config.mappings").aerial(bufnr))
  end,
})

-- if telescope loaded then load the aerial plugin as well.
pcall(require("telescope").load_extension, "aerial")
