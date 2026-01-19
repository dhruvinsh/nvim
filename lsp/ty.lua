---@type vim.lsp.Config
return {
  cmd = { "ty", "server" },
  filetypes = { "python" },
  root_markers = { "Pipfile", "pyproject.toml", "requirements.txt", "ty.toml", ".git" },
  on_attach = function(client)
    client.server_capabilities.definitionProvider = nil
    client.server_capabilities.typeDefinitionProvider = nil
    client.server_capabilities.referencesProvider = nil
    client.server_capabilities.implementationProvider = nil
  end,
}
