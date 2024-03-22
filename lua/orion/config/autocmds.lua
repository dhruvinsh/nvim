local utils = require("utils")

-- Closing unused buffer:
-- https://www.reddit.com/r/neovim/comments/12c4ad8/closing_unused_buffers/
vim.api.nvim_create_autocmd({ "BufRead" }, {
  group = utils.augroup("unused_buffer"),
  pattern = { "*" },
  callback = function()
    vim.api.nvim_create_autocmd({ "InsertEnter", "BufModifiedSet" }, {
      buffer = 0,
      once = true,
      callback = function() utils.persistbuffer() end,
    })
  end,
})

-- spell check for some filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = utils.augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- highlight yank text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = utils.augroup("yank_highlight"),
  callback = function() vim.highlight.on_yank() end,
  pattern = "*",
})

-- I do use some other editor at the same time, lets check if the file is modified
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = utils.augroup("checktime"),
  command = "checktime",
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = utils.augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then return end
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = utils.augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "git",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "fugitiveblame",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  group = utils.augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event) vim.bo[event.buf].buflisted = false end,
})
