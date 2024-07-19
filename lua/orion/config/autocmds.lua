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

-- folds
-- vim.opt.foldtext = ""
-- vim.opt.foldenable = true
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart = 99
-- vim.opt.foldmethod = "expr"
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  --   foldsep = " ",
  --   diff = "╱",
  --   eob = " ",
}

local opt = vim.opt
local fn = vim.fn
local fc = vim.opt.fillchars:get()

local function get_fold(lnum)
  if fn.foldlevel(lnum) <= fn.foldlevel(lnum - 1) then
    return " "
  end
  return fn.foldclosed(lnum) == -1 and fc.foldopen or fc.foldclose
end

_G.get_statuscol = function()
  if vim.opt_local.signcolumn:get() == "yes" then
    return get_fold(vim.v.lnum) .. "%s%l%= " .. " "
  else
    return ""
  end
end

opt.statuscolumn = "%!v:lua.get_statuscol()"
