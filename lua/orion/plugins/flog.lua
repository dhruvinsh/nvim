return {
  "rbong/vim-flog",
  cmd = { "Flog", "Flogsplit", "Floggit" },
  dependencies = { "tpope/vim-fugitive" },
  keys = {
    { "<leader>gf", "<cmd>Flogsplit<CR>", desc = "flog" },
    { "<leader>gF", "<cmd>Flog<CR>", desc = "flog (tab)" },
  },
}
