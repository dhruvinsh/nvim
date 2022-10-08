-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- [[ Spell Check ]]
-- close certain filetype with jsut q button
local close_group = vim.api.nvim_create_augroup("SimpleClose", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.keymap.set("n", "q", ":close <CR>", { noremap = true, silent = true })
  end,
  group = close_group,
  pattern = { "qf", "help", "man", "lspinfo", "startuptime" },
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Hide bufferline if dashboard is open
local toggle_bufferline = vim.api.nvim_create_augroup("ToggleBufferline", { clear = true })
vim.api.nvim_create_autocmd("User", {
  callback = function()
    vim.o.showtabline = 0
  end,
  group = toggle_bufferline,
  pattern = "AlphaReady",
})
vim.api.nvim_create_autocmd("BufUnload", {
  callback = function()
    vim.o.showtabline = 2
  end,
  group = toggle_bufferline,
  pattern = "<buffer>",
})
