vim.keymap.set("n", "<leader>fu", vim.cmd.UndotreeToggle)

local undodir = vim.fn.expand("~/.undodir")
if not vim.fn.isdirectory(undodir) then
  vim.fn.mkdir(undodir, "p", 0700)
end

vim.opt.undodir = undodir
