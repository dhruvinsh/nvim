-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- lazygit
-- map("n", "<leader>gg", function() LazyVim.lazygit( { cwd = LazyVim.root.git() }) end, { desc = "Lazygit (Root Dir)" })
-- map("n", "<leader>gG", function() LazyVim.lazygit() end, { desc = "Lazygit (cwd)" })
-- map("n", "<leader>gb", LazyVim.lazygit.blame_line, { desc = "Git Blame Line" })
--
-- map("n", "<leader>gf", function()
--   local git_path = vim.api.nvim_buf_get_name(0)
--   LazyVim.lazygit({args = { "-f", vim.trim(git_path) }})
-- end, { desc = "Lazygit Current File History" })
--
-- map("n", "<leader>gl", function()
--   LazyVim.lazygit({ args = { "log" } })
-- end, { desc = "Lazygit Log" })
-- vim.keymap.del("n", "<leader>gg")
vim.keymap.del("n", "<leader>gG")
vim.keymap.del("n", "<leader>gb")
vim.keymap.del("n", "<leader>gf")
vim.keymap.del("n", "<leader>gl")

vim.keymap.del("n", "<leader>l")
vim.keymap.set("n", "<leader>lL", "<cmd>Lazy <CR>", { desc = "Lazy" })
