---@type vim.lsp.Config
return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
  root_markers = { ".git" },
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      -- NOTE: keep it disable since using b0o/SchemaStore.nvim
      schemaStore = { enable = false, url = "" },
      schema = {},
    },
  },
  before_init = function(_, config)
    config.settings.yaml.schema = require("schemastore").yaml.schemas()
  end,
}
