vim.keymap.set("n", "<leader>gP", function()
  vim.cmd.Git("push")
end, { desc = "Push" })
vim.keymap.set("n", "<leader>gp", function()
  vim.cmd.Git({ "pull" })
end, { desc = "Pull" })
vim.keymap.set("n", "<leader>gD", "<cmd>Gvdiffsplit!<CR>", { desc = "Diff Split" })