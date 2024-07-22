local M = {}

--- LSP symbol kinds.
-- stylua: ignore start
M.symbols       = {
  Array         = "󰅪",
  Class         = "",
  Color         = "󰏘",
  Constant      = "󰏿",
  Constructor   = "",
  Enum          = "",
  EnumMember    = "",
  Event         = "",
  Field         = "󰜢",
  File          = "󰈙",
  Folder        = "󰉋",
  Function      = "󰆧",
  Interface     = "",
  Keyword       = "󰌋",
  Method        = "󰆧",
  Module        = "",
  Operator      = "󰆕",
  Property      = "󰜢",
  Reference     = "󰈇",
  Snippet       = "",
  Struct        = "",
  Text          = "",
  TypeParameter = "",
  Unit          = "",
  Value         = "",
  Variable      = "󰀫",
}

M.misc          = {
  bug           = '',
  ellipsis      = '…',
  git           = '',
  search        = '',
  vertical_bar  = '│',
}

M.diagnostics   = {
  ERROR         = '',
  WARN          = '',
  HINT          = '',
  INFO          = '',
}
-- stylua: ignore end

M.get_statuscolumn = function()
  local fc = vim.opt.fillchars:get()
  local function get_fold(lnum)
    if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then
      return " "
    end
    return vim.fn.foldclosed(lnum) == -1 and fc.foldopen or fc.foldclose
  end

  if vim.opt_local.signcolumn:get() == "yes" then
    -- fold info + line number
    return "%s%l%= " .. get_fold(vim.v.lnum) .. " "
  else
    return ""
  end
end

return M
