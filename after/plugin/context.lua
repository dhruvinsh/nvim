local tc = require("treesitter-context")
local utils = require("utils")

tc.setup({
  ---@param bufnr integer
  on_attach = function(bufnr)
    -- it requres inverse loginc
    return not utils.is_big_buffer(bufnr)
  end,
})

vim.keymap.set("n", "[c", tc.go_to_context, { silent = true, desc = "Context" })
