local status_ok, session = pcall(require, "session_manager")

if not status_ok then
  return
end

session.setup({
  autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
  autosave_last_session = true, -- Automatically save last session on exit and on session switch.
  autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
  autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
    "gitcommit",
  },
})
