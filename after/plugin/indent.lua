local utils = require("utils")
local no_indent_filetypes = {
  "Trouble",
  "dashboard",
  "help",
  "lazy",
  "mason",
  "neo-tree",
  "notify",
  "toggleterm",
}

require("ibl").setup({
  indent = {
    char = "│",
    tab_char = "│",
  },
  scope = { enabled = false },
  exclude = {
    filetypes = no_indent_filetypes,
  },
})

require("mini.indentscope").setup({
  symbol = "│",
  options = { try_as_border = true },
})

vim.api.nvim_create_autocmd("FileType", {
  group = utils.augroup("mini_indent_disable"),
  pattern = no_indent_filetypes,
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

-- disable based on big file
vim.api.nvim_create_autocmd("BufReadPre", {
  group = utils.augroup("big_file_disable", false),
  pattern = "*",
  callback = function(ev)
    if utils.is_big_buffer(ev.buf) then
      vim.notify("Big File: disabling indent", vim.log.levels.WARN)
      vim.b.miniindentscope_disable = true
      vim.cmd("IBLDisable")
    end
  end,
})
