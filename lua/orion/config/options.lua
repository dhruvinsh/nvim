vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- completion
vim.opt.completeopt = "menuone,noselect,noinsert"
vim.opt.pumborder = "rounded"
vim.opt.pummaxwidth = 100
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
vim.opt.iskeyword = "@,48-57,_,192-255,-" -- Treat dash as `word` textobject part
-- NOTE: something here breaks the lsp "K" mappings upon restore
-- vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Folding.
vim.opt.fillchars = {
  diff = "╱",
  fold = "┄",
  foldclose = "",
  foldopen = "",
  eob = " ",
}
vim.opt.foldcolumn = "1"
vim.opt.foldlevelstart = 99
vim.wo.foldtext = ""

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
vim.opt.diffopt:append({ "followwrap,vertical,context:100,linematch:100" })

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
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Neovide specific config
if vim.g.neovide then
  vim.o.guifont = "Iosevka Nerd Font:h13"
  vim.opt.linespace = 0
end
