local M = {}
M.__index = M

function M:new(name, state, action)
  local obj = {
    name = name,
    state = state,
    action = action,
  }
  setmetatable(obj, M)
  return obj
end

function M:toggle()
  self.state = not self.state
  self.action(self.state)
end

--
-- Collection of the toggles
--
local H = {}

H.diagnostic = M:new("diagnostic", true, function(state)
  vim.diagnostic.enable(state)
end)

H.format_local = M:new("format (local)", true, function(state)
  if state then
    vim.cmd("FormatEnable")
    vim.notify("Local format is enabled", vim.log.levels.INFO)
  else
    vim.cmd("FormatDisable!")
    vim.notify("Local format is disabled", vim.log.levels.INFO)
  end
end)

H.format_global = M:new("format (global)", true, function(state)
  if state then
    vim.cmd("FormatEnable")
    vim.notify("Global format is enabled", vim.log.levels.INFO)
  else
    vim.cmd("FormatDisable")
    vim.notify("Global format is disabled", vim.log.levels.INFO)
  end
end)

H.inlay_hint = M:new("inlay hint", true, function(state)
  vim.lsp.inlay_hint.enable(state)
end)

-- toggle vim.o.background "dark" or "light"
H.colorscheme = M:new("colorscheme", vim.o.background == "dark", function(state)
  vim.o.background = state and "dark" or "light"
  vim.cmd.colorscheme(vim.g.colorscheme)
end)

-- toggle wrap
H.wrap = M:new("wrap", vim.o.wrap, function(state)
  vim.o.wrap = state
end)

return H
