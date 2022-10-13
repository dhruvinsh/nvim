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

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
--- NOTE: switch to uses native API keymap.set
--- vim.keymap.set()
--- set({mode}, {lhs}, {rhs}, {opts}) vim.keymap.set() Add a new mapping. Examples:
--- -- Can add mapping to Lua functions
--- vim.keymap.set('n', 'lhs', function() print("real lua function") end)
---
--- -- Can use it to map multiple modes
--- vim.keymap.set({'n', 'v'}, '<leader>lr', vim.lsp.buf.references, { buffer=true })
---
--- -- Can add mapping for specific buffer
--- vim.keymap.set('n', '<leader>w', "<cmd>w<cr>", { silent = true, buffer = 5 })
--- -- Expr mappings
--- vim.keymap.set('i', '<Tab>', function()
---   return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
--- end, { expr = true })
--- -- <Plug> mappings
--- vim.keymap.set('n', '[%', '<Plug>(MatchitNormalMultiBackward)')
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
local default_opts = {
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  nowait = false, -- use `nowait` when creating keymaps
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
}

--- see orion/plugins/config/mapping.lua for the reference
--- Mapping looks like below:
--- M.buffer = {
---   n = {
---     ["<S-Tab>"] = { ":bp <CR>", "Pext Buffer" },
---     ["<leader>bp"] = { ":bp <CR>", "Pext Buffer" },
---   },
--- }
---@param group_maps table
M.build_keymap = function(group_maps)
  -- from example, group_name: buffer
  -- from example, groups: table inside M.buffer
  for group_name, groups in pairs(group_maps) do
    -- from example, mode: n
    -- from example, mappings: table assign to "n"
    for mode, mappings in pairs(groups) do
      for lhs, data in pairs(mappings) do
        local rhs = data[1]

        local opts = default_opts
        -- it is possible that desc is not provided
        if data[2] ~= nil then
          opts = vim.tbl_deep_extend("keep", opts, { desc = data[2] })
        end

        if data[3] ~= nil then
          opts = vim.tbl_deep_extend("keep", opts, data[3])
        end

        -- print(mode .. " " .. lhs .. " " .. vim.inspect(opts))
        vim.keymap.set(mode, lhs, rhs, opts)
      end
    end
  end
end

return M
