return {
  "folke/todo-comments.nvim",
  event = "BufReadPost",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "]t", "<cmd>lua require('todo-comments').jump_next()<CR>", desc = "todo" },
    { "[t", "<cmd>lua require('todo-comments').jump_prev()<CR>", desc = "todo" },
  },
  opts = {},
}
