local M = {}

--- validate if its a function
--- credits: mrjones2014/legendary.nvim
---@param a string
---@return boolean
M.is_function = function(a)
  if type(a) == "function" then
    return true
  end

  local mt = getmetatable(a)
  if not mt then
    return false
  end

  return not not mt.__call
end

--- lazy() takes the first argument (a function)
--- and calls it with the rest of the arguments
--- require('legendary.helpers').lazy(vim.lsp.buf.formatting_sync, nil, 1500)
--- this will *return a new function* defined as:
--- function()
---   vim.lsp.buf.formatting_sync(nil, 1500)
--- end
--- credits: mrjones2014/legendary.nvim
---@param fn function
---@vararg any
---@return function
M.lazy = function(fn, ...)
  local args = { ... }
  return function()
    fn(unpack(args))
  end
end

--- lazy_required_fn() takes a module path as the first argument,
--- a function name from that module as the second argument,
--- and returns a new function that calls the function by name
--- with the rest of the arguments
--- lazy_required_fn('telescope.builtin', 'oldfiles', { only_cwd = true })
--- this will *return a new function* defined as:
--- function()
---   require('telescope.bulitin')['oldfiles']({ only_cwd = true })
--- end
--- credits: mrjones2014/legendary.nvim
---@param module_name string
---@param fn_name string
---@vararg any
---@return function
M.lazy_required_fn = function(module_name, fn_name, ...)
  local args = { ... }
  return function()
    local module = (_G["require"](module_name))
    if string.find(fn_name, "%.") then
      local fn = module
      for _, key in ipairs(vim.split(fn_name, "%.")) do
        fn = (fn)[key]
        if fn == nil then
          vim.notify("invalid lazy_required_fn usage: no such function path")
          return
        end
      end
      if not M.is_function(fn) then
        vim.notify("invalid lazy_required_fn usage: no such function path")
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

--- build whichkey compatible keymap from group of keymaps
---@param maps table
M.build_keymap = function(maps)
  local KEYMAP = {}

  for group, keymaps in pairs(maps) do
    -- work on actual keymap, unlike aerial keymaps, see mappings.lua
    if not vim.is_callable(keymaps) then
      for mode, keymap in pairs(keymaps) do
        local keys = vim.tbl_keys(KEYMAP)
        if not vim.tbl_contains(keys, mode) then
          KEYMAP[mode] = {}
        end

        KEYMAP[mode] = vim.tbl_deep_extend("keep", KEYMAP[mode], keymap)
      end
    end
  end

  return KEYMAP
end

return M
