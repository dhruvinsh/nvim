local utils = require("utils")

-- Closing unused buffer:
-- https://www.reddit.com/r/neovim/comments/12c4ad8/closing_unused_buffers/
vim.api.nvim_create_autocmd({ "BufRead" }, {
  group = utils.augroup("unused_buffer"),
  pattern = { "*" },
  callback = function()
    vim.api.nvim_create_autocmd({ "InsertEnter", "BufModifiedSet" }, {
      buffer = 0,
      once = true,
      callback = function()
        utils.persistbuffer()
      end,
    })
  end,
})
