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

return M
