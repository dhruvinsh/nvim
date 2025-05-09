-- color scheme
vim.keymap.set("n", "<leader>tc", "<cmd>lua require('util.toggle').colorscheme:toggle()<cr>", { desc = "colors" })
-- ease of life
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "clear search + escape" })
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- editor
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "save" })
vim.keymap.set("i", "<C-s>", "<C-o><cmd>w<cr>", { desc = "save" })
vim.keymap.set("n", "<C-S-s>", "<cmd>wa<cr>", { desc = "save all" })
vim.keymap.set("i", "<C-S-s>", "<C-o><cmd>wa<cr>", { desc = "save all" })
vim.keymap.set("n", "<leader>tw", "<cmd>lua require('util.toggle').wrap:toggle()<cr>", { desc = "wrap" })

-- indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

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

-- tabs
vim.keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "next" })
vim.keymap.set("n", "<leader><tab>[", "<cmd>tabprev<cr>", { desc = "prev" })
vim.keymap.set("n", "<leader><tab>n", "<cmd>tabnew<cr>", { desc = "new" })
vim.keymap.set("n", "<leader><tab>c", "<cmd>tabclose<cr>", { desc = "close" })

-- tools
vim.keymap.set("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "lazy" })

--- LSP
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

  keymap("gra", "<cmd>lua require('fastaction').code_action()<CR>", "code action", { "n", "v" })
  keymap("grr", "<cmd>FzfLua lsp_references formatter=path.filename_first<cr>", "references")

  if client:supports_method(methods.textDocument_definition, bufnr) then
    keymap("gD", "<cmd>FzfLua lsp_definitions<cr>", "peek definition")
    keymap("gd", function()
      require("fzf-lua").lsp_definitions({ jump1 = true })
    end, "definition")
  end

  if client:supports_method(methods.textDocument_documentHighlight, bufnr) then
    local under_cursor_highlights_group = vim.api.nvim_create_augroup("doc_highlight", { clear = false })
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

  if client:supports_method(methods.textDocument_inlayHint, bufnr) then
    vim.defer_fn(function()
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end, 500)

    vim.keymap.set(
      "n",
      "<leader>ti",
      "<cmd>lua require('util.toggle').inlay_hint:toggle()<cr>",
      { desc = "inlay hints" }
    )
  end

  if client:supports_method(methods.textDocument_signatureHelp) then
    local blink_window = require("blink.cmp.completion.windows.menu")
    local blink = require("blink.cmp")

    keymap("<C-k>", function()
      -- Close the completion menu first (if open).
      if blink_window.win:is_open() then
        blink.hide()
      end

      vim.lsp.buf.signature_help()
    end, "Signature help", "i")
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
