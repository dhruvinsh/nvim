require("toggleterm").setup({
  open_mapping = [[<c-\>]],
})

vim.keymap.set("n", "<leader>ft", function()
  vim.cmd.ToggleTerm({ "size=15" })
end, { desc = "Terminal" })
