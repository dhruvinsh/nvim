local util = require("orion.util")
local M = {}

--- Build lsp capabilities
---@return unknown
M.capabilities = function(opts)
  -- new changes on cmp_nvim_lsp allows to use capabilities directly
  local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

  return vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    has_cmp and cmp_nvim_lsp.default_capabilities() or {},
    opts.capabilities or {}
  )
end

--- Make on_attach to connect current buffer to LSP
---@param client table
---@param buffer integer
M.on_attach = function(client, buffer)
  -- nvim-navic setup
  if util.has("nvim-navic") then
    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, buffer)
    end
  end

  -- Keymap setting for LSP
  require("orion.plugins.lsp.keymaps").on_attach(client, buffer)
end

return M
