local db = require("dashboard")
local utils = require("utils")

local config_path = vim.fn.stdpath("config")
local logo = [[
   ██████╗ ██████╗ ██╗ ██████╗ ███╗   ██╗
  ██╔═══██╗██╔══██╗██║██╔═══██╗████╗  ██║
  ██║   ██║██████╔╝██║██║   ██║██╔██╗ ██║
  ██║   ██║██╔══██╗██║██║   ██║██║╚██╗██║
  ╚██████╔╝██║  ██║██║╚██████╔╝██║ ╚████║
  ╚═════╝ ╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝ 
]]

db.setup({
  theme = "doom",
  change_to_vcs_root = true,
  config = {
    header = vim.split(string.rep("\n", 8) .. logo .. "\n\n", "\n"),
    -- stylua: ignore
    center = {
      { action = "Telescope find_files",                     desc = " Find file", icon = " ", key = "f" },
      { action = "Telescope projects",                       desc = " Projects",  icon = " ", key = "p" },
      { action = "ene | startinsert",                        desc = " New file",  icon = " ", key = "n" },
      { action = "SessionManager load_current_dir_session",  desc = " Session",   icon = "󰳿 ", key = "s" },
      { action = "Telescope find_files cwd=" .. config_path, desc = " Config",    icon = " ", key = "c" },
      { action = "Lazy restore",                             desc = " Restore",   icon = "󰊳 ", key = "r" },
      { action = "silent qa",                                desc = " Quit",      icon = " ", key = "q" },
    },
    footer = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
    end,
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
