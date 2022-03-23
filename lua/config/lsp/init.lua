-------------------------------------
--            LSP setup            --
-------------------------------------

-- collection of server to be install
local servers = {
  pyright = {},
  sumneko_lua = {},
  cssls = {},
  tsserver = {},
  dockerls = {},
  html = {},
  jsonls = {},
  eslint = {},
}

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  require("lsp_signature").on_attach(client)
  require("config.lsp.keymaps").setup(client, bufnr)
  require("config.lsp.highlighting").setup(client)
  require("config.lsp.code_lens").setup(client)

  -- client specific override
  if client.name == "typescript" then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local options = {
  on_attach = on_attach,
  capabilities = capabilities,
}

require("config.lsp.null_ls").setup(options)
require("config.lsp.installer").setup(servers, options)
