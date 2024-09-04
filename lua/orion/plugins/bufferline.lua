return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  opts = function()
    local bufferline = require("bufferline")

    return {
      options = {
        themable = true,
        style_preset = bufferline.style_preset.no_italic,
        numbers = "ordinal",
        close_command = function(bufnr)
          require("mini.bufremove").delete(bufnr, false)
        end,
        indicator = { style = "icon" },
        truncate_names = false,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diag)
          local icons = require("util.ui").diagnostics
          local indicator = (diag.error and icons.ERROR .. " " or "") .. (diag.warning and icons.WARN or "")
          return vim.trim(indicator)
        end,
        separator_style = "slope",
      },
    }
  end,
  keys = {
    { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "previous buffer" },
    { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "next buffer" },
    { "<leader>bc", "<cmd>BufferLinePickClose<cr>", desc = "close" },
  },
}
