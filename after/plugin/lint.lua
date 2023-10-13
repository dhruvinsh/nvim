----------------------------------------------------
-- Linter
----------------------------------------------------
local utils = require("utils")

local linters = {
  -- python
  "mypy",
  "ruff",
}
-- NOTE: on ARM mac, some formatter doesn't work if installed via mason
-- chezmoi takes care of their installation.
if not utils.is_mac then
  utils.tbl_append(linters, "selene", "shellcheck")
end

-- install all the the valid linter and formatter
local mr = require("mason-registry")
for _, tool in ipairs(linters) do
  local p = mr.get_package(tool)
  if not p:is_installed() then
    p:install()
  end
end

require("lint").linters_by_ft = {
  bash = { "shellcheck" },
  lua = { "selene" },
  python = { "ruff", "mypy" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = utils.augroup("nvim_lint"),
  callback = function()
    require("lint").try_lint()
  end,
})
