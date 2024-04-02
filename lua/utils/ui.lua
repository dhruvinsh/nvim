local M = {}

M.kinds = {
  Array = " ",
  Boolean = "󰨙 ",
  Class = " ",
  Codeium = "󰘦 ",
  Color = " ",
  Control = " ",
  Collapsed = " ",
  Constant = "󰏿 ",
  Constructor = " ",
  Copilot = " ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = "󰊕 ",
  Interface = " ",
  Key = " ",
  Keyword = " ",
  Method = "󰊕 ",
  Module = " ",
  Namespace = "󰦮 ",
  Null = " ",
  Number = "󰎠 ",
  Object = " ",
  Operator = " ",
  Package = " ",
  Property = " ",
  Reference = " ",
  Snippet = " ",
  String = " ",
  Struct = "󰆼 ",
  Text = " ",
  TypeParameter = " ",
  Unit = " ",
  Value = " ",
  Variable = "󰀫 ",
}

M.diagnostics = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
  [1] = " ", -- error
  [2] = " ", -- warn
  [3] = " ", -- hint
  [4] = " ", -- info
}

M.dap = {
  Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
  Breakpoint = { " ", "DiagnosticInfo" },
  BreakpointCondition = { " ", "DiagnosticInfo" },
  BreakpointRejected = { " ", "DiagnosticError" },
  LogPoint = { ".>", "DiagnosticInfo" },
}

return M
