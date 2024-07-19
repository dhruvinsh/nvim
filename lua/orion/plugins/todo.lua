return {
  "folke/todo-comments.nvim",
  event = "BufReadPost",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "]t",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "todo",
    },
    {
      "[t",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "todo",
    },
  },
  opts = {},
}
