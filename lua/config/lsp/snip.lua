local luasnip = require("luasnip")
luasnip.config.set_config({
  history = true,
  -- Update more often, :h events for more info.
  updateevents = "TextChanged,TextChangedI",
})
require("luasnip/loaders/from_vscode").load()
