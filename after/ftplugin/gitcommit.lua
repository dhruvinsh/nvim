local cmp = require("cmp")

-- fugitive autocompletion
---@diagnostic disable-next-line
cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "git" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),
})

require("cmp_git").setup()
