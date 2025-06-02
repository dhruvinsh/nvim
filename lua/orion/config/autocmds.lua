local utils = require("util")

-- yank highlight
vim.api.nvim_create_autocmd("TextYankPost", {
  group = utils.augroup("yank_highlight"),
  desc = "highlight yank",
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Check for modified files due external effects
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = utils.augroup("modified_files"),
  desc = "check if file modified externally",
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd.checktime()
    end
  end,
})

-- remember the last
vim.api.nvim_create_autocmd("BufReadPost", {
  group = utils.augroup("last_location", true),
  desc = "remember the last",
  callback = function(event)
    -- gitcommit poses some issues,
    -- HACK: ignore gitcommit
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].__last_loc then
      return
    end
    vim.b[buf].__last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- nice and quick exit
vim.api.nvim_create_autocmd("FileType", {
  group = utils.augroup("close_with_q"),
  desc = "close with q",
  pattern = {
    "checkhealth",
    "floggraph",
    "git",
    "help",
    "man",
    "qf",
    "query",
  },
  callback = function(args)
    vim.bo[args.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = args.buf, silent = true })
  end,
})

-- folds
-- awesome folds
vim.api.nvim_create_autocmd("BufReadPre", {
  group = utils.augroup("big_file_disable", false),
  callback = function(ev)
    if utils.is_big_buffer(ev.buf) then
      -- fallback to default values
      vim.opt.foldmethod = "manual"
      vim.opt.foldexpr = "0"
      vim.opt.foldlevel = 0
      vim.opt.foldtext = "foldtext()"
    else
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.opt.foldlevel = 99
      vim.opt.foldtext = ""
    end
  end,
})
vim.api.nvim_create_autocmd("LspAttach", {
  group = utils.augroup("lsp_based_fold", false),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_foldingRange) then
      local win = vim.api.nvim_get_current_win()
      if vim.wo[win].foldmethod == "expr" then
        vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
      end
    end
  end,
})

-- codecompanion: gitcommit accept
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "CodeCompanionDiffAttached",
  group = utils.augroup("gitcommit_accept", true),
  callback = function(request)
    local bufnr = request.data.bufnr
    if vim.bo[bufnr].filetype == "gitcommit" then
      vim.defer_fn(function()
        vim.api.nvim_feedkeys("ga", "t", false)
      end, 200)
    end
  end,
})
