-- install treesitter packages
-- :TSInstall norg norg_meta norg_table
require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.norg.concealer"] = {},
    ["core.export"] = {},
    ["core.export.markdown"] = {},
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    },
    ["core.integrations.nvim-cmp"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          study = "~/Documents/study",
        },
      },
    },
  },
})
