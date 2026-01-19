---@type vim.lsp.Config
return {
  cmd = { "ty", "server" },
  filetypes = { "python" },
  root_markers = { "Pipfile", "pyproject.toml", "requirements.txt", "ty.toml", ".git" },
  settings = {
    ty = {
      -- give it a fer more months to mature
      disableLanguageServices = true,
    },
  },
}
