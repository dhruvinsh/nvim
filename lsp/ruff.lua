---@type vim.lsp.Config
return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { ".git", "Pipfile", "pyproject.toml", "requirements.txt" },
  settings = {},
}
