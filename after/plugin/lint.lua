----------------------------------------------------
-- Linter
----------------------------------------------------
local utils = require("utils")

local linters = {}

-- NOTE: on ARM mac, some formatter doesn't work if installed via mason
-- chezmoi takes care of their installation.
if not utils.is_mac then
  utils.tbl_append(linters, "selene", "shellcheck")
end

require("after.plugin.helper").mason_pkg_installer(linters)

require("lint").linters_by_ft = {
  bash = { "shellcheck" },
  lua = { "selene" },
  python = { "ruff", "mypy" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  group = utils.augroup("nvim_lint"),
  callback = function()
    require("lint").try_lint()
  end,
})
