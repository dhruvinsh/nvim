return {
  "stevearc/conform.nvim",
  event = "BufReadPost",
  opts = {
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
      return { timeout_ms = 1000, lsp_fallback = true }
    end,
    format_after_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
      return { lsp_fallback = true }
    end,
    formatters_by_ft = {
      bash = { "shfmt" },
      lua = { "stylua" },
      markdown = { "cbfmt", "prettierd" },
      python = { "ruff_format" },
      ["_"] = { "trim_whitespace" },
    },
    formatters = {
      injected = { options = { ignore_errors = true } },
    }
  },
  config = function(_, opts)
    local formatters = {
      -- shell
      "shfmt",
      -- lua
      "stylua",
      -- markdown
      "cbfmt",
      "vale",
      -- js, html, markdown and lot of others
      "prettierd",
    }
    require("utils.lsp").mason_pkg_installer(formatters)

    require("conform").setup(opts)

    -- set vim default formatexpr
    vim.opt.formatexpr = "v:lua.require('conform').formatexpr()"
  end
}
