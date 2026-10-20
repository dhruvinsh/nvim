-- Read-only viewers for xlsx, docx and pdf. Only these autocmds are created at
-- startup; the `orion.viewer` modules are required the first time such a file is opened.
-- Lives in after/ so it runs after the builtin zip browser (runtime/plugin/zip.lua),
-- whose xlsx/docx handlers would otherwise replace the rendered view.
local formats = {
  xlsx = { "*.xlsx", "*.xlsm" },
  docx = { "*.docx", "*.docm" },
  pdf = { "*.pdf" },
}

local group = require("util").augroup("viewer")
for format, patterns in pairs(formats) do
  pcall(vim.api.nvim_clear_autocmds, { group = "nvim.zip", event = "BufReadCmd", pattern = patterns })
  vim.api.nvim_create_autocmd("BufReadCmd", {
    group = group,
    pattern = patterns,
    desc = "Render " .. format .. " as read-only text",
    callback = function(args)
      require("orion.viewer").read(args.buf, args.match, require("orion.viewer." .. format))
    end,
  })
end
