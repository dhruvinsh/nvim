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

-- terminal: Aider
vim.api.nvim_create_autocmd({ "TermOpen", "TermClose" }, {
  group = utils.augroup("aider_console", false),
  pattern = "term://*aider*",
  callback = function(ev)
    if ev.event == "TermOpen" then
      vim.opt_local.number = false
      vim.opt_local.signcolumn = "no"
    else -- TermClose
      local enter_key = vim.api.nvim_replace_termcodes("<CR>", true, true, true)
      vim.api.nvim_feedkeys(enter_key, "n", false)
    end
  end,
})
