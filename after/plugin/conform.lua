----------------------------------------------------
-- Formatter
----------------------------------------------------

local formatters = {
  -- python
  "black",
  "blackd-client",
  "isort",
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

-- install all the the valid formatters with mason
local mr = require("mason-registry")
for _, tool in ipairs(formatters) do
  local p = mr.get_package(tool)
  if not p:is_installed() then
    p:install()
  end
end

require("conform").setup({
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 1000, lsp_fallback = true }
  end,
  format_after_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { lsp_fallback = true }
  end,
  formatters_by_ft = {
    bash = { "shfmt" },
    lua = { "stylua" },
    markdown = { "cbfmt", "prettierd" },
    python = { "isort", { "blackd", "black" } },
  },
  formatters = {
    injected = { options = { ignore_errors = true } },
  },
})

-- set vim default formatexpr
vim.opt.formatexpr = "v:lua.require('conform').formatexpr()"

-- User commands
-- :Format
vim.api.nvim_create_user_command("Format", function(args)
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
    vim.notify("Formatter is disable", vim.log.levels.ERROR)
    return
  end

  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_fallback = true, range = range, timeout_ms = 1000 })
end, { range = true })

-- :FormatDisable (global) or :FormatDisable! (current buffer)
vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    vim.notify("Local formatter disable")
    vim.b.disable_autoformat = true
  else
    vim.notify("Global formatter disable")
    vim.g.disable_autoformat = true
  end
end, { desc = "Disable autoformt on save", bang = true })

-- :FormatEnable (global or current buffer)
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
  vim.notify("Formatter enable")
end, { desc = "Enable autoformat on save" })

-- :FormatToggle (global) or :FormatToggle! (current buffer)
vim.api.nvim_create_user_command("FormatToggle", function(args)
  if vim.b.disable_autoformat or vim.g.disable_autoformat then
    vim.cmd.FormatEnable()
  else
    if args.bang then
      vim.cmd("FormatDisable!")
    else
      vim.cmd("FormatDisable")
    end
  end
end, { desc = "Enable autoformat on save", bang = true })

-- some vim keymaps
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  vim.cmd("Format")
end, { desc = "Format" })
vim.keymap.set({ "n", "v" }, "<leader>cF", function()
  require("conform").format({ formatters = { "injected" } })
end, { desc = "Format Injected" })

vim.keymap.set("n", "<leader>bf", function()
  vim.cmd("FormatToggle!")
end, { desc = "Fomat Toggle (Local)" })
vim.keymap.set("n", "<leader>tf", function()
  vim.cmd("FormatToggle")
end, { desc = "Format Toggle (Global)" })
