local db = require("dashboard")
local utils = require("utils")

local config_path = vim.fn.stdpath("config")

-- db.setup({
--   theme = "doom",
--   change_to_vcs_root = true,
--   config = {
--     header = vim.split(string.rep("\n", 8) .. "" .. "\n\n", "\n"),
--     -- week_header = {
--     --   enable = true,
--     -- },
--     -- stylua: ignore
--     center = {
--       { action = "Telescope find_files",                     desc = " Find file", icon = " ", key = "f" },
--       { action = "ene | startinsert",                        desc = " New file",  icon = " ", key = "n" },
--       { action = 'lua require("persistence").load()',        desc = " Session",   icon = " ", key = "s" },
--       { action = "Telescope find_files cwd=" .. config_path, desc = " Config",    icon = " ", key = "c" },
--       { action = "Lazy update",                              desc = " Update",    icon = "󰊳 ", key = "l" },
--       { action = "qa",                                       desc = " Quit",      icon = " ", key = "q" },
--     },
--     footer = function()
--       local stats = require("lazy").stats()
--       local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
--       return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
--     end,
--   },
-- })

-- NOTE: old hyper theme

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
        icon = "󰳿 ",
        icon_hl = "@variable",
        desc = "Session",
        group = "@string.escape",
        action = "SessionManager load_current_dir_session",
        key = "s",
      },
      {
        icon = " ",
        icon_hl = "@variable",
        desc = "Config",
        group = "@class",
        action = "Telescope find_files dir=" .. config_path,
        key = "c",
      },
      {
        icon = "󰊳 ",
        icon_hl = "@variable",
        desc = "Restore",
        group = "@variable.builtin",
        action = "Lazy restore",
        key = "r",
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

-- Lazy causes dashboard not to load.
if vim.o.filetype == "lazy" then
  vim.cmd.close()
  vim.api.nvim_create_autocmd("User", {
    pattern = "DashboardLoaded",
    group = utils.augroup("dashboard_fix"),
    callback = function() require("lazy").show() end,
  })
end
