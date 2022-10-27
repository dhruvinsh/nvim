local neodev_status_ok, neodev = pcall(require, "neodev")
if neodev_status_ok then
  neodev.setup({})
end

local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
  return
end

local ml_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ml_status_ok then
  return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local handler = require("orion.lsp.handlers")

-- TODO: better alternative require
local servers = {
  "bashls",
  "jsonls",
  "pyright",
  "sumneko_lua",
}

mason.setup()
mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
})

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = handler.on_attach,
    capabilities = handler.capabilities(),
  }

  local require_ok, conf_opts = pcall(require, "orion.configs.lsp.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  lspconfig[server].setup(opts)
end
