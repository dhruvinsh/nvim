---@type vim.lsp.Config
return {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  init_options = {
    provideFormatter = true,
  },
  root_markers = { ".git" },
  settings = {
    json = {
      validate = { enable = true },
      format = { enable = true },
    },
  },
  before_init = function(_, config)
    config.settings.json.schema = require("schemastore").json.schemas()
  end,
}
