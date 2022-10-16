local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

-- Work on capabilities
--- create lsp capabilities
---@return unknown
M.capabilities = function()
  -- new changes on cmp_nvim_lsp allows to use capabilities directly
  local capabilities = cmp_nvim_lsp.default_capabilities()

  return capabilities
end

--- Make on_attach to connect current buffer to LSP
---@param client table
---@param bufnr integer
M.on_attach = function(client, bufnr)
  -- NOTE: come up better option here
  -- client specific override
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end
  if client.name == "sumneko_lua" then
    client.server_capabilities.documentFormattingProvider = false
  end

  -- Keymap setting for LSP
  local keymaps = require("orion.core.mappings").lsp(bufnr)
  require("orion.core.util").setup_keymap(keymaps)

  -- illuminate setup
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
end

return M
