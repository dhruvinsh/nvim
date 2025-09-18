local M = {}
M.__index = M

---@class ToggleIconConfig
---@field enabled? string
---@field disabled? string

---@class ToggleWkPrefixesConfig
---@field enabled? string
---@field disabled? string

---@class ToggleConfig
---@field icon? string | ToggleIconConfig
---@field prefixes? string | ToggleWkPrefixesConfig

---@param name string toggle property name
---@param state boolean initial state of the given property
---@param action fun(state: boolean) method to toggle the given property
---@param config? ToggleConfig toggle related config
function M:new(name, state, action, config)
  local obj = {
    name = name,
    state = state,
    action = action,
  }

  config = config or {}
  local default_icons = { enabled = " ", disabled = " " }
  local default_prefixes = { enabled = " disable ", disabled = " enable " }

  obj.icon = default_icons
  if type(config.icon) == "table" then
    obj.icon = {
      enabled = config.icon.enabled,
      disabled = config.icon.disabled,
    }
  end

  obj.prefixes = default_prefixes
  if type(config.prefixes) == "table" then
    obj.prefixes = {
      enabled = config.prefixes.enabled,
      disabled = config.prefixes.disabled,
    }
  end

  setmetatable(obj, M)
  return obj
end

function M:toggle()
  self.state = not self.state
  self.action(self.state)
end

function M:map_and_register(mode, keys)
  vim.keymap.set(mode, keys, function()
    self:toggle()
  end, { desc = "Toggle " .. self.name, silent = true })

  require("which-key").add({
    {
      keys,
      mode = mode,
      icon = function()
        return {
          icon = self.state and self.icon.enabled or self.icon.disabled,
          color = self.state and "green" or "yellow",
        }
      end,
      desc = function()
        local prefix = self.state and self.prefixes.enabled or self.prefixes.disabled
        return prefix .. self.name
      end,
      real = true,
    },
  })
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

-- toggle context
H.context = M:new("context", true, function(state)
  if state then
    require("treesitter-context").enable()
  else
    require("treesitter-context").disable()
  end
end)

return H
