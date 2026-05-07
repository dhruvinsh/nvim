return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost" },
  config = function()
    local lint = require("lint")
    local utils = require("util")

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
