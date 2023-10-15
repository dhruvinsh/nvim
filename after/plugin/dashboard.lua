local db = require("dashboard")

db.setup({
  theme = "hyper",
  change_to_vcs_root = true,
  config = {
    week_header = {
      enable = true,
    },
    shortcut = {
      {
        icon = " ",
        icon_hl = "@variable",
        desc = "Files",
        group = "Number",
        action = "Telescope find_files",
        key = "f",
      },
      {
        icon = " ",
        icon_hl = "@variable",
        desc = "Projects",
        group = "@method",
        action = "Telescope projects",
        key = "p",
      },
      {
        icon = " ",
        icon_hl = "@variable",
        desc = "Session",
        group = "@string.escape",
        action = 'lua require("persistence").load()',
        key = "s",
      },
      {
        icon = "󰊳 ",
        icon_hl = "@variable",
        desc = "Update",
        group = "@variable.builtin",
        action = "Lazy update",
        key = "u",
      },
      {
        icon = " ",
        icon_hl = "@variable",
        desc = "Close",
        group = "@parameter",
        action = "qa",
        key = "q",
      },
    },
  },
})
