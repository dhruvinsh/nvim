local M = {}

-- keybindings
M.setup = function(client, bufnr)
  -- Few keymaping
  local wk = require "which-key"
  local keys = {
    ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show hover" },
    ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
    ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto declaration" },
    ["gr"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "Goto references" },
    ["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto implementation" },
    ["gs"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "show signature help" },
    ["gp"] = { "<cmd>lua require'lsp.peek'.Peek('definition')<CR>", "Peek definition" },
    ["gl"] = {
      "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false, border = 'single' })<CR>",
      "Show line diagnostics",
    },
  }

  -- Set some conditional keympa based on server capabilities
  if client.resolved_capabilities.document_formatting then
    keys["<space>bf"] = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format" }
  elseif client.resolved_capabilities.document_range_formatting then
    keys["<space>bf"] = { "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "Format" }
  end

  wk.register(keys, { mode = "n", buffer = bufnr })

end

return M
