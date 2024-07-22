local utils = require("utils")

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
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= count then
      vim.cmd('normal! g`"zz')
    end
  end,
})

-- nice and quick exit
vim.api.nvim_create_autocmd("FileType", {
  group = utils.augroup("close_with_q"),
  desc = "close with q",
  pattern = {
    "help",
    "man",
    "qf",
  },
  callback = function(args)
    vim.keymap.set("n", "q", "<cmd>quite<cr>", { buffer = args.buf })
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
