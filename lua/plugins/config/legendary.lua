local status_ok, legendary = pcall(require, "legendary")

if not status_ok then
  return
end

legendary.setup({
  keymaps = require("plugins.config.mappings").default_keymaps()
})

