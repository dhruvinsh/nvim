local M = {}

function M.lazy(fn, ...)
  local args = { ... }
  return function()
    fn(unpack(args))
  end
end

local function is_function(a)
  if type(a) == "function" then
    return true
  end

  local mt = getmetatable(a)
  if not mt then
    return false
  end

  return not not mt.__call
end

function M.lazy_required_fn(module_name, fn_name, ...)
  local args = { ... }
  return function()
    local module = (_G["require"](module_name))
    if string.find(fn_name, "%.") then
      local fn = module
      for _, key in ipairs(vim.split(fn_name, "%.")) do
        fn = (fn)[key]
        if fn == nil then
          vim.notify("[legendary.nvim]: invalid lazy_required_fn usage: no such function path")
          return
        end
      end
      if not is_function(fn) then
        vim.notify("[legendary.nvim]: invalid lazy_required_fn usage: no such function path")
        return
      end
      local final_fn = fn
      final_fn(unpack(args))
    else
      local fn = module[fn_name]
      fn(unpack(args))
    end
  end
end

function M.split_then(fn)
  return function()
    vim.cmd("sp")
    fn()
  end
end

function M.vsplit_then(fn)
  return function()
    vim.cmd("vsp")
    fn()
  end
end

local M = {}

local generic_opts_any = { noremap = true, silent = true }

local generic_opts = {
  insert_mode = generic_opts_any,
  normal_mode = generic_opts_any,
  visual_mode = generic_opts_any,
  visual_block_mode = generic_opts_any,
  command_mode = generic_opts_any,
  term_mode = { silent = true },
}

local mode_adapters = {
  insert_mode = "i",
  normal_mode = "n",
  term_mode = "t",
  visual_mode = "v",
  visual_block_mode = "x",
  command_mode = "c",
}

---@class Keys
---@field insert_mode table
---@field normal_mode table
---@field terminal_mode table
---@field visual_mode table
---@field visual_block_mode table
---@field command_mode table

if vim.fn.has("mac") == 1 then
  defaults.normal_mode["<A-Up>"] = defaults.normal_mode["<C-Up>"]
  defaults.normal_mode["<A-Down>"] = defaults.normal_mode["<C-Down>"]
  defaults.normal_mode["<A-Left>"] = defaults.normal_mode["<C-Left>"]
  defaults.normal_mode["<A-Right>"] = defaults.normal_mode["<C-Right>"]
end

-- Unsets all keybindings defined in keymaps
-- @param keymaps The table of key mappings containing a list per mode (normal_mode, insert_mode, ..)
function M.clear(keymaps)
  local default = M.get_defaults()
  for mode, mappings in pairs(keymaps) do
    local translated_mode = mode_adapters[mode] or mode
    for key, _ in pairs(mappings) do
      -- some plugins may override default bindings that the user hasn't manually overridden
      if default[mode][key] ~= nil or (default[translated_mode] ~= nil and default[translated_mode][key] ~= nil) then
        pcall(vim.keymap.del, translated_mode, key)
      end
    end
  end
end

-- Set key mappings individually
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param key The key of keymap
-- @param val Can be form as a mapping or tuple of mapping and user defined opt
function M.set_keymaps(mode, key, val)
  local opt = generic_opts[mode] or generic_opts_any
  if type(val) == "table" then
    opt = val[2]
    val = val[1]
  end
  if val then
    vim.keymap.set(mode, key, val, opt)
  else
    pcall(vim.api.nvim_del_keymap, mode, key)
  end
end

-- Load key mappings for a given mode
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param keymaps The list of key mappings
function M.load_mode(mode, keymaps)
  mode = mode_adapters[mode] or mode
  for k, v in pairs(keymaps) do
    M.set_keymaps(mode, k, v)
  end
end

-- Load key mappings for all provided modes
-- @param keymaps A list of key mappings for each mode
function M.load(keymaps)
  keymaps = keymaps or {}
  for mode, mapping in pairs(keymaps) do
    M.load_mode(mode, mapping)
  end
end

-- local defaults = {
--   insert_mode = {
--     ["<A-j>"] = "<Esc>:m .+1<CR>==gi",
--   },
-- }
--
-- -- Load the default keymappings
-- function M.load_defaults()
--   M.load(M.get_defaults())
--   lvim.keys = lvim.keys or {}
--   for idx, _ in pairs(defaults) do
--     if not lvim.keys[idx] then
--       lvim.keys[idx] = {}
--     end
--   end
-- end
--
-- -- Get the default keymappings
-- function M.get_defaults()
--   return defaults
-- end

return M
