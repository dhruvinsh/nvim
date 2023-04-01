return {
  {
    "echasnovski/mini.align",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function(_, opts)
      require("mini.align").setup(opts)
    end,
  },
}
