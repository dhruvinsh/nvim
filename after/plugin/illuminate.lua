local utils = require("utils")

require("illuminate").configure({
  providers = { "lsp" },
  delay = 200,
})

-- disable based on big file
vim.api.nvim_create_autocmd("BufReadPre", {
  group = utils.augroup("big_file_disable", false),
  pattern = "*",
  callback = function(ev)
    if utils.is_big_buffer(ev.buf) then
      vim.notify("Big File: disabling illuminate", vim.log.levels.WARN)
      vim.cmd("IlluminatePauseBuf")
    end
  end,
})
