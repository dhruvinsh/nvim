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
  root_markers = { "Pipfile", "pyproject.toml", "requirements.txt", ".git" },
}
