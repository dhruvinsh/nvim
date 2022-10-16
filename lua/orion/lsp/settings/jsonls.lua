local status_ok, schemastore = pcall(require, "schemastore")

if not status_ok then
  return {}
end

return {
  settings = {
    json = {
      format = {
        enable = true,
      },
      schemas = schemastore.json.schemas(),
      validate = { enable = true },
    },
  },
}
