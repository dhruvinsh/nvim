-- vim.pack-managed plugins (gradual migration from lazy.nvim).
--
-- lazy.nvim trims 'packpath' down to just the runtime directory, which breaks
-- the :packadd that vim.pack relies on to load plugins (E919). Restore the data
-- site directory so packages installed under site/pack/core/opt are findable.
vim.opt.packpath:append(vim.fn.stdpath("data") .. "/site")

-- Load one file per plugin from lua/orion/pack/. Each file owns a single plugin:
-- it calls vim.pack.add{...} and then configures the plugin. Sorted so load
-- order is deterministic.
local dir = vim.fn.stdpath("config") .. "/lua/orion/pack"
if vim.fn.isdirectory(dir) == 1 then
  local files = vim.fn.globpath(dir, "*.lua", false, true)
  table.sort(files)
  for _, file in ipairs(files) do
    require("orion.pack." .. vim.fn.fnamemodify(file, ":t:r"))
  end
end
