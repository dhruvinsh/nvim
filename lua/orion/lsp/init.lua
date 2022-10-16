local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

-- NOTE: proper sequence is required
require("orion.lsp.setup")
require("orion.lsp.visual")

-- some other added helper for LSP
require("orion.lsp.cmp")
require("orion.lsp.null-ls")
