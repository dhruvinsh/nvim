-- ease of life
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "clear search + escape" })
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- editor
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "save" })
vim.keymap.set("i", "<C-s>", "<C-o><cmd>w<cr>", { desc = "save" })
vim.keymap.set("n", "<C-S-s>", "<cmd>wa<cr>", { desc = "save all" })
vim.keymap.set("i", "<C-S-s>", "<C-o><cmd>wa<cr>", { desc = "save all" })

-- buffers
vim.keymap.set("n", "<S-h>", "<cmd>bprev<cr>", { desc = "previous" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "next" })

-- windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "w-left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "w-down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "w-up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "w-left" })
vim.keymap.set("n", "<leader>wd", "<C-w>c", { desc = "close" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "vertical" })
vim.keymap.set("n", "<leader>wx", "<C-w>s", { desc = "split" })

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

  keymap("grr", "<cmd>FzfLua lsp_references formatter=path.filename_first<cr>", "references")
  keymap("gy", "<cmd>FzfLua lsp_typedefs<cr>", "type definition")
  keymap("<leader>cr", vim.lsp.buf.rename, "rename")

  if client.supports_method(methods.textDocument_definition) then
    keymap("gD", "<cmd>FzfLua lsp_definitions<cr>", "peek definition")
    keymap("gd", function()
      require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
    end, "definition")
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

    if not client then
      return
    end

    on_attach(client, args.buf)
  end,
})
