local M = {}

M.ui = {
  theme_toggle = { "onedark", "one_light" },
  theme = "onedark",
}

M.plugins = require("custom.plugins")

M.mappings = require("custom.mappings")

return M
