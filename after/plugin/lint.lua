----------------------------------------------------
-- Linter
----------------------------------------------------
local lint = require("lint")
local utils = require("utils")

local linters = { "markdownlint", "codespell" }

-- NOTE: on ARM mac, some formatter doesn't work if installed via mason
-- chezmoi takes care of their installation.
if not utils.is_mac then utils.tbl_append(linters, "selene", "shellcheck") end

require("utils.helper").mason_pkg_installer(linters)

lint.linters_by_ft = {
  bash = { "shellcheck" },
  lua = { "selene" },
  markdown = { "markdownlint" },
  python = { "ruff", "mypy" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  group = utils.augroup("nvim_lint"),
  callback = function()
    if not utils.is_big_buffer(vim.api.nvim_get_current_buf()) then
      lint.try_lint()
      lint.try_lint("codespell")
    end
  end,
})
