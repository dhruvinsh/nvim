vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- completion
vim.opt.completeopt = "menuone,noselect,noinsert"
vim.opt.pumheight = 10

-- column
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.statuscolumn = [[%!v:lua.require("util.ui").get_statuscolumn()]]

-- timings
vim.opt.updatetime = 200
vim.opt.timeoutlen = 300

-- editor
vim.opt.virtualedit = "block"
vim.opt.formatoptions = "jcroqlnt"
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2

-- folds
vim.opt.fillchars = {
  diff = "╱",
  fold = " ",
  foldclose = "",
  foldopen = "",
  eob = " ",
}

-- undo
vim.opt.undofile = true
vim.opt.undolevels = 10000

-- mouse
vim.opt.mouse = "a"

-- Show whitespace.
vim.opt.list = true
vim.opt.listchars = { tab = "  ↦" }

-- Status line.
vim.opt.laststatus = 3
vim.opt.cmdheight = 1

-- split
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "screen"

-- messages
vim.opt.shortmess:append({
  w = true,
  s = true,
  I = true,
})

-- Git diff
vim.opt.diffopt:append({ "vertical,context:100,linematch:100" })

-- cursor
vim.opt.cursorline = true

-- GUI!?
vim.opt.termguicolors = true

-- spell
vim.opt.spelllang = { "en" }
vim.opt.spelloptions:append("noplainbuffer")
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Markdown indentation
vim.g.markdown_recommended_style = 0

local utils = require("util")

-- setup volta
if vim.fn.executable("volta") then
  vim.g.node_host_prog = vim.fn.trim(vim.fn.system("volta which neovim-node-host"))
end

-- setup python
if utils.is_win then
  if vim.fn.executable("python") then
    vim.g.python3_host_prog = "python"
  end
-- on linux and mac os I use pyenv to manage python, soon to be `Rye`
elseif vim.fn.executable("pyenv") then
  local py_version = vim.fn.trim(vim.fn.system("pyenv global"))
  vim.g.python3_host_prog = "~/.pyenv/versions/" .. py_version .. "/bin/python3"
end

-- Neovide specific config
if vim.g.neovide then
  vim.o.guifont = "FiraCode Nerd Font:h10"
  vim.opt.linespace = 0
end
