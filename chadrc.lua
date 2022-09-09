-- Just an example, supposed to be placed in /lua/custom/

local M = {}
local pluginConfs = require "custom.plugins.configs"

-- make sure you maintain the structure of `core/default_config.lua` here,
M.plugins = {
  override = {
    ["williamboman/mason.nvim"] = pluginConfs.mason,
  },
  user = require "custom.plugins",
}

M.mappings = require "custom.mappings"

return M
