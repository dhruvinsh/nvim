-- close certain filetype with jsut q button
local close_group = vim.api.nvim_create_augroup("SimpleClose", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.keymap.set("n", "q", ":close <CR>", { noremap = true, silent = true })
  end,
  group = close_group,
  pattern = { "qf", "help", "man", "lspinfo", "startuptime" },
})

-- Spell Check with wrap
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

-- Toggle nvim-treesitter-context
local toggle_treesitter_context = vim.api.nvim_create_augroup("ToggleTreesitterContext", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    local status_ok, tcontext = pcall(require, "treesitter-context")
    if not status_ok then
      return
    end
    if vim.bo.filetype == "json" then
      tcontext.disable()
    else
      tcontext.enable()
    end
  end,
  group = toggle_treesitter_context,
  pattern = "*",
})

-- matchparen highlight fix
local matchparen_highlight = vim.api.nvim_create_augroup("MatchParenHighlight", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "MatchParen", { bold = true, standout = true })
  end,
  group = matchparen_highlight,
  pattern = "*",
})