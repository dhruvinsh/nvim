return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "BufReadPost",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>tt", desc = "context" },
  },
  config = function(_, opts)
    require("treesitter-context").setup(opts)
    require("util.toggle").context:map_and_register("n", "<leader>tt")
  end,
}
