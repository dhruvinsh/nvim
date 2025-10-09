---@type vim.lsp.Config
return {
  cmd = { "ruff", "server" },
  cmd_env = { RUFF_TRACE = "messages" },
  filetypes = { "python" },
  init_options = {
    settings = {
      logLevel = "error",
    },
  },
  root_markers = { ".git", "Pipfile", "pyproject.toml", "requirements.txt" },
  settings = {},
}
