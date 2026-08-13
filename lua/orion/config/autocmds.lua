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
vim.api.nvim_create_autocmd("FileType", {
  group = utils.augroup("big_file_fold_disable", true),
  desc = "treesitter folding",
  callback = function(ev)
    if vim.bo[ev.buf].filetype ~= "bigfile" and pcall(vim.treesitter.start, ev.buf) then
      vim.wo[0][0].foldmethod = "expr"
      vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.cmd.normal("zx")
    end
  end,
})

-- disable harper_ls at the beginning
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "disable harper_ls by default",
  once = true,
  callback = function()
    vim.defer_fn(function()
      vim.lsp.enable("harper_ls", false)
      vim.notify("Harper LS disabled by default. Use <leader>ts to toggle.", vim.log.levels.INFO)
    end, 3000)
  end,
})
