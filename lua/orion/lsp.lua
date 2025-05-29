--- LSP
---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
  local methods = vim.lsp.protocol.Methods

  ---Generic keymap function for LSP-related actions.
  ---@param lhs string
  ---@param rhs string|function
  ---@param desc string
  ---@param mode? string|string[]
  local keymap = function(lhs, rhs, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  keymap("gra", "<cmd>lua require('fastaction').code_action()<CR>", "code action", { "n", "x" })
  keymap("grr", "<cmd>FzfLua lsp_references formatter=path.filename_first<cr>", "references")

  if client:supports_method(methods.textDocument_definition, bufnr) then
    keymap("gd", "<cmd>FzfLua lsp_definitions { jump1 = true }<cr>", "definition")
    keymap("gD", "<cmd>FzfLua lsp_definitions { jump1 = false}<cr>", "peek definition")
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

    require("util.toggle").inlay_hint:map_and_register("n", "<leader>ti")
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

-- Set up LSP servers.
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  once = true,
  callback = function()
    local server_configs = vim
      .iter(vim.api.nvim_get_runtime_file("lsp/*.lua", true))
      :map(function(file)
        return vim.fn.fnamemodify(file, ":t:r")
      end)
      :totable()
    vim.lsp.enable(server_configs)
  end,
})
