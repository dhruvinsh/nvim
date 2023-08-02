local M = {}

-- diagnostic helper function
M.diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

---@type PluginLspKeys
M._keys = nil

---@return (LazyKeys|{has?:string})[]
M.get = function()
  local format = function()
    require("orion.plugins.lsp.format").format({ force = true })
  end

  if not M._keys then
  ---@class PluginLspKeys
    -- stylua: ignore
    M._keys =  {
      -- lspconfig related mappings
      { "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },

      -- lsp formatting mappings
      -- { "<leader>cf", format, desc = "Format Document", has = "formatting" },
      -- { "<leader>cf", format, desc = "Format Range", mode = "v", has = "rangeFormatting" },

      -- lsp related mappings
      { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
      {
        "<leader>cA",
        function()
          vim.lsp.buf.code_action({ context = { only = { "source", }, diagnostics = {}, }, })
        end,
        desc = "Source Action", has = "codeAction"
      },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
      { "<leader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
      { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
      { "K", vim.lsp.buf.hover, desc = "Hover" },
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      { "gI", "<cmd>Telescope lsp_implementations reuse_win=true<cr>", desc = "Goto Implementation" },
      { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
      { "gd", "<cmd>Telescope lsp_definitions reuse_win=true<cr>", desc = "Goto Definition", has = "definition" },
      { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
      { "gy", "<cmd>Telescope lsp_type_definitions reuse_win=true<cr>", desc = "Goto T[y]pe Definition" },

      -- lsp diagnostic mappings
      { "]d", M.diagnostic_goto(true), desc = "Next Diagnostic" },
      { "[d", M.diagnostic_goto(false), desc = "Prev Diagnostic" },
      { "]e", M.diagnostic_goto(true, "ERROR"), desc = "Next Error" },
      { "[e", M.diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
      { "]w", M.diagnostic_goto(true, "WARN"), desc = "Next Warning" },
      { "[w", M.diagnostic_goto(false, "WARN"), desc = "Prev Warning" },

      -- code formatting
      { "<leader>cf", format, desc = "Format Document", has = "formatting" },
      { "<leader>cf", format, desc = "Format Range", mode = "v", has = "rangeFormatting" },

    }
  end

  return M._keys
end

---@param method string
M.has = function(client, method)
  method = method:find("/") and method or "textDocument/" .. method
  if client.supports_method(method) then
    return true
  end
  return false
end

M.resolve = function()
  local Keys = require("lazy.core.handler.keys")
  local keymaps = {} ---@type table<string,LazyKeys|{has?:string}>

  local function add(keymap)
    local keys = Keys.parse(keymap)
    if keys[2] == false then
      keymaps[keys.id] = nil
    else
      keymaps[keys.id] = keys
    end
  end

  for _, keymap in ipairs(M.get()) do
    add(keymap)
  end

  return keymaps
end

M.on_attach = function(client, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = M.resolve()

  for _, keys in pairs(keymaps) do
    if not keys.has or M.has(client, keys.has) then
      local opts = Keys.opts(keys)
      ---@diagnostic disable-next-line: no-unknown
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
    end
  end
end

return M
