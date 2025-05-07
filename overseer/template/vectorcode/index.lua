---@module overseer
---@type overseer.TemplateDefinition
return {
  name = "VectorCode job",
  condition = {
    callback = function()
      local vectorcode = vim.fs.root(0, { ".vectorcode" })
      if vectorcode == nil or vim.fn.executable("vectorcode") == 0 then
        return false
      end
      vim.notify("Found the vectorcode config", vim.log.levels.INFO)
      return true
    end,
  },
  builder = function()
    return {
      cmd = { "vectorcode" },
      args = { "update" },
      components = {
        { "on_output_quickfix", set_diagnostics = true },
        "on_result_diagnostics",
        "default",
      },
    }
  end,
}
