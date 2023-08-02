local util = require("lazy.core.util")
local M = {}

---@type PluginLspOpts
M.opts = nil

function M.enabled()
  return M.opts.autoformat
end

function M.toggle()
  if vim.b.autoformat == false then
    vim.b.autoformat = nil
    M.opts.autoformat = true
  else
    M.opts.autoformat = not M.opts.autoformat
  end
  if M.opts.autoformat then
    util.info("Enabled format on save", { title = "Format" })
  else
    util.warn("Disabled format on save", { title = "Format" })
  end
end

-- Gets all lsp clients that support formatting.
-- When a null-ls formatter is available for the current filetype,
-- only null-ls formatters are returned.
function M.get_formatters(bufnr)
  local ft = vim.bo[bufnr].filetype
  -- check if we have any null-ls formatters for the current filetype
  local null_ls = package.loaded["null-ls"] and require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") or {}

  ---@class LazyVimFormatters
  local ret = {
    ---@type lsp.Client[]
    active = {},
    ---@type lsp.Client[]
    available = {},
    null_ls = null_ls,
  }

  ---@type lsp.Client[]
  local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
  for _, client in ipairs(clients) do
    if M.supports_format(client) then
      if (#null_ls > 0 and client.name == "null-ls") or #null_ls == 0 then
        table.insert(ret.active, client)
      else
        table.insert(ret.available, client)
      end
    end
  end

  return ret
end

-- Gets all lsp clients that support formatting
-- and have not disabled it in their client config
---@param client lsp.Client
function M.supports_format(client)
  if
    client.config
    and client.config.capabilities
    and client.config.capabilities.documentFormattingProvider == false
  then
    return false
  end
  return client.supports_method("textDocument/formatting") or client.supports_method("textDocument/rangeFormatting")
end

-- function that is responsible to perform the formatting
function M.format(opts)
  -- if autoformat is disable just return
  if vim.b.autoformat == false and not (opts and opts.force) then
    return
  end

  -- if there are no formatter just return
  local buf = vim.api.nvim_get_current_buf()
  local formatters = M.get_formatters(buf)
  local client_ids = vim.tbl_map(function(client)
    return client.id
  end, formatters.active)
  print(vim.inspect(client_ids))

  if #client_ids == 0 then
    return
  end

  vim.lsp.buf.format(vim.tbl_deep_extend("force", {
    bufnr = buf,
    filter = function(client)
      return vim.tbl_contains(client_ids, client.id)
    end,
  }, {
    formatting_options = nil,
    timeout_ms = nil,
  }))
end

-- auto command creation for formatting purpose
M.create_autocmd = function()
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("orion_format", {}),
    callback = function()
      if M.enabled() then
        M.format()
      end
    end,
  })
end

---@param opts PluginLspOpts
function M.setup(opts)
  M.opts = opts
  M.create_autocmd()
end

return M
