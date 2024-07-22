local utils = require("utils")

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
