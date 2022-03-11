-- install treesitter packages
-- :TSInstall norg norg_meta norg_table
require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.norg.concealer"] = {},
    ["core.norg.completion"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          study = "~/Documents/study",
        }
      }
    },
  }
})
