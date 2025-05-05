return {
  "stevearc/conform.nvim",
  version = "*",
  event = { "BufReadPost" },
  cmd = { "ConformInfo" },
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      -- disable for vendor folder, like vendor folder in python project
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname:match("/vendor/") then
        return
      end

      return { timeout_ms = 1000, lsp_format = "fallback" }
    end,
    format_after_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { lsp_format = "fallback" }
    end,
    formatters_by_ft = {
      bash = { "shfmt" },
      html = { "prettierd" },
      json = { "prettierd" },
      jsonc = { "prettierd" },
      lua = { "stylua" },
      markdown = { "cbfmt", "prettierd" },
      python = { "ruff_format", "ruff_organize_imports" },
      yaml = { "prettierd" },
      ["_"] = { "trim_whitespace" },
    },
    formatters = {
      injected = { options = { ignore_errors = true } },
    },
  },
  keys = function()
    return {
      { "<leader>lc", "<cmd>ConformInfo<cr>", desc = "conform" },
      { "<leader>tf", "<cmd>lua require('util.toggle').format_local:toggle()<cr>", desc = "format (local)" },
      { "<leader>tF", "<cmd>lua require('util.toggle').format_global:toggle()<cr>", desc = "format (global)" },
    }
  end,
  init = function()
    -- set vim default formatexpr
    vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
  end,
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
    require("util.lsp").mason_pkg_installer(formatters)

    require("conform").setup(opts)

    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })
  end,
}
