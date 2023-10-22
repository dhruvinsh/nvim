local tc = require("treesitter-context")
local utils = require("utils")

tc.setup({
  max_lines = 3,
  min_window_height = 40,
  ---@param bufnr integer
  on_attach = function(bufnr)
    -- on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    -- it requires inverse loginc
    local is_big = utils.is_big_buffer(bufnr)
    if is_big then
      vim.notify("Big File: disabling treesitter context", vim.log.levels.WARN)
    end
    return not is_big
  end,
})

vim.keymap.set("n", "[c", tc.go_to_context, { silent = true, desc = "Context" })
