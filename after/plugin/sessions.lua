local config = require("session_manager.config")

require("session_manager").setup({
  autoload_mode = config.AutoloadMode.Disabled,
  autosave_ignore_filetypes = {
    "gitcommit",
    "gitrebase",
    "fugitive",
  },
})
