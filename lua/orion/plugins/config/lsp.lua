-- lua dev need to setup befor lsp
-- I don't want to stop execution just because lua_dev is not loaded
local lua_dev_status_ok, lua_dev = pcall(require, "lua-dev")
if lua_dev_status_ok then
  lua_dev.setup({})
end

local status_ok, lspconfig = pcall(require, "lspconfig")

if not status_ok then
  return
end

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local keymaps = require("orion.core.mappings")
  local util = require("orion.core.util")

  local mappings = keymaps.lsp(bufnr)

  util.setup_keymap(mappings)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Setup mason so it can manage external tooling
require("mason").setup()

-- Enable the following language servers
local servers = {
  "clangd",
  "jsonls",
  "pyright",
  "rust_analyzer",
  "sumneko_lua",
  "tsserver",
}

-- Ensure the servers above are installed
require("mason-lspconfig").setup({
  ensure_installed = servers,
})

for _, lsp in ipairs(servers) do
  if lsp == "sumneko_lua" then
    lspconfig[lsp].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      setting = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })
  else
    lspconfig[lsp].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end
end
