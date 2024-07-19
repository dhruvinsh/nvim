-- ease of life
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "clear search + escape" })

-- buffers
vim.keymap.set("n", "<S-h>", "<cmd>bprev<cr>", { desc = "previous" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "next" })

-- tools
vim.keymap.set("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "lazy" })

--- Lsp

---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
  local methods = vim.lsp.protocol.Methods

  ---@param lhs string
  ---@param rhs string|function
  ---@param desc string
  ---@param mode? string|string[]
  local keymap = function(lhs, rhs, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  keymap("grr", "<cmd>FzfLua lsp_references<cr>", "vim.lsp.buf.references()")

  keymap("gy", "<cmd>FzfLua lsp_typedefs<cr>", "Go to type definition")

  keymap("<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", "Document symbols")
  keymap("<leader>fS", function()
    -- Disable the grep switch header.
    require("fzf-lua").lsp_live_workspace_symbols({ no_header_i = true })
  end, "Workspace symbols")

  keymap("[d", function()
    vim.diagnostic.jump({ count = -1 })
  end, "Previous diagnostic")
  keymap("]d", function()
    vim.diagnostic.jump({ count = 1 })
  end, "Next diagnostic")
  keymap("[e", function()
    vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
  end, "Previous error")
  keymap("]e", function()
    vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
  end, "Next error")

  if client.supports_method(methods.textDocument_definition) then
    keymap("gD", "<cmd>FzfLua lsp_definitions<cr>", "Peek definition")
    keymap("gd", function()
      require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
    end, "Go to definition")
  end

  if client.supports_method(methods.textDocument_signatureHelp) then
    keymap("<C-k>", function()
      -- Close the completion menu first (if open).
      local cmp = require("cmp")
      if cmp.visible() then
        cmp.close()
      end

      vim.lsp.buf.signature_help()
    end, "Signature help", "i")
  end

  if client.supports_method(methods.textDocument_documentHighlight) then
    local under_cursor_highlights_group = vim.api.nvim_create_augroup("mariasolos/cursor_highlights", { clear = false })
    vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
      group = under_cursor_highlights_group,
      desc = "Highlight references under the cursor",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
      group = under_cursor_highlights_group,
      desc = "Clear highlight references",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  if client.supports_method(methods.textDocument_inlayHint) then
    vim.defer_fn(function()
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end, 500)

    -- TODO: need to work on building toggle command
    --
    -- vim.api.nvim_create_autocmd("InsertEnter", {
    --   desc = "Enable inlay hints",
    --   buffer = bufnr,
    --   callback = function()
    --     vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
    --   end,
    -- })
    -- vim.api.nvim_create_autocmd("InsertLeave", {
    --   desc = "Disable inlay hints",
    --   buffer = bufnr,
    --   callback = function()
    --     vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    --   end,
    -- })
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Configure LSP keymaps",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- I don't think this can happen but it's a wild world out there.
    if not client then
      return
    end

    on_attach(client, args.buf)
  end,
})
