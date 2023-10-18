require("rose-pine").setup({
  disable_italics = true,
  highlight_groups = {
    Comment = { italic = true },
  },
})

vim.cmd.colorscheme("rose-pine")
