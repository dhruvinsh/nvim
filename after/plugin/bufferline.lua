local ui = require("utils.ui")
local utils = require("utils")

---@diagnostic disable:missing-fields
require("bufferline").setup({
  options = {
    close_command = function(n)
      require("mini.bufremove").delete(n, false)
    end,
    right_mouse_command = function(n)
      require("mini.bufremove").delete(n, false)
    end,
    diagnostics = "nvim_lsp",
    always_show_bufferline = false,
    diagnostics_indicator = function(_, _, diag)
      local icons = ui.diagnostics
      local ret = (diag.error and icons.Error .. diag.error .. " " or "")
        .. (diag.warning and icons.Warn .. diag.warning or "")
      return vim.trim(ret)
    end,
    offsets = {
      {
        filetype = "neo-tree",
        text = " NeoTree",
        highlight = "Directory",
        text_align = "left",
      },
    },
  },
})

vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete non-pinned buffers" })
vim.keymap.set("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle pin" })
vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

-- HACK: When I resotre the session with persistence.nvim all the buffer doesn't appear
vim.api.nvim_create_autocmd("BufAdd", {
  group = utils.augroup("rstore_bufferline"),
  callback = function()
    vim.schedule(function()
      -- NOTE: this is a global function part of bufferline.nvim, _G.nvim_bufferline, ignore the diag error
      pcall(nvim_bufferline)
    end)
  end,
})
