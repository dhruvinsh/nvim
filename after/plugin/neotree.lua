require("neo-tree").setup({
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_by_name = {
        ".git",
      },
    },
    follow_current_file = { enabled = true },
  },
})
vim.keymap.set("n", "<leader>fe", ":Neotree toggle <cr>", { desc = "Explorer" })
