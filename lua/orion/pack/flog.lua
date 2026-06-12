-- vim-flog — git branch viewer (graph log)
-- https://github.com/rbong/vim-flog
-- Requires vim-fugitive (already loaded eagerly via lua/orion/pack/fugitive.lua).
vim.pack.add({
  { src = "https://github.com/rbong/vim-flog" },
}, { load = true })

vim.keymap.set("n", "<leader>gf", "<cmd>Flogsplit<CR>", { desc = "flog" })
vim.keymap.set("n", "<leader>gF", "<cmd>Flog<CR>", { desc = "flog (tab)" })
