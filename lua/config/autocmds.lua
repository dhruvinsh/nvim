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

-- close some filetypes with <q>
-- override the lazyvim autocmds.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("lazyvim_close_with_q", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "git",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "fugitiveblame",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})
