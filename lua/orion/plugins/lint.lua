return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost" },
  config = function()
    local lint = require("lint")
    local utils = require("util")

    local linters = { "codespell", "golangci-lint", "markdownlint-cli2" }

    -- NOTE: on ARM mac, some formatter doesn't work if installed via mason
    -- chezmoi takes care of their installation.
    if not utils.is_mac then
      utils.tbl_append(linters, "selene", "shellcheck")
    end

    require("util.lsp").mason_pkg_installer(linters)

    lint.linters_by_ft = {
      bash = { "shellcheck" },
      go = { "golangcilint" },
      lua = { "selene" },
      markdown = { "markdownlint-cli2" },
      python = { "ruff" },
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
  end,
}
