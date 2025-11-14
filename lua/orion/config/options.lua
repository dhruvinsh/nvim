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
vim.opt.conceallevel = 1
vim.opt.virtualedit = "block"
vim.opt.formatoptions = "jcroqlnt"
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2
-- NOTE: something here breaks the lsp "K" mappings upon restore
-- vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

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

-- disable some providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

local utils = require("util")

-- setup mise
if vim.fn.executable("mise") then
  vim.g.node_host_prog = vim.fn.trim(vim.fn.system("mise which neovim-node-host"))
end

-- setup python
if utils.is_win then
  if vim.fn.executable("python") then
    vim.g.python3_host_prog = "python"
  end
-- on Linux and MacOS I use Mise to manage Python versions
elseif vim.fn.executable("mise") then
  -- mise ls --json | jq '."pipx:pynvim"[0].install_path'
  vim.g.python3_host_prog = vim.fn
    .trim(vim.fn.system("mise ls --json | jq '.\"pipx:pynvim\"[0].install_path'"))
    :gsub("^[\"']", "")
    :gsub("[\"']\n?$", "") .. "/pynvim/bin/python"
end

-- Neovide specific config
if vim.g.neovide then
  vim.o.guifont = "FiraCode Nerd Font:h10"
  vim.opt.linespace = 0
end
