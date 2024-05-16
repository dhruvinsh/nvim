return {
  "windwp/nvim-autopairs",
  opts = {
    fast_wrap = {}, -- just enable fast_wrap
  },
  config = function(_, opts)
    require("nvim-autopairs").setup(opts)
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
