--- VectorCode Index template for overseer
---
---@module "overseer"
---@type overseer.TemplateDefinition
return {
  name = "VectorCode index",
  condition = {
    callback = function()
      local vectorcode = vim.fs.root(0, { ".vectorcode" })
      if vectorcode == nil then
        vim.notify(".vectorcode directory not found", vim.log.levels.ERROR)
        return false, ".vectorcode directory not found"
      end
      if vim.fn.executable("vectorcode") == 0 then
        vim.notify("vectorcode executable not found", vim.log.levels.ERROR)
        return false, "vectorcode executable not found"
      end
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
