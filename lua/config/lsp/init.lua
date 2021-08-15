-- CREDITS: defaults.nvim, folke/dot, LunarVim, lspinstall, Kabouzeid

local lspconfig = require("lspconfig")
local lspinstall = require("lspinstall")

-- change some minor LSP visual changes
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = { prefix = "●" } })
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })

vim.api.nvim_command("highlight default link LspCodeLens Comment")

-- enable on_attach
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- client specific override
  if client.name == "typescript" then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  require("lsp_signature").on_attach(client)
  require("config.lsp.keymaps").setup(client, bufnr)

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
    augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]],
      false
    )
  end
  if client.resolved_capabilities.code_lens then
    vim.cmd([[
    augroup lsp_codelens
      autocmd! * <buffer>
      autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
    augroup END
    ]])
  end
  if client.server_capabilities.colorProvider then
    require("config.lsp.documentcolors").buf_attach(bufnr, { single_column = true })
  end
end

-- pre-setup config maker
-- config that activates keymaps and enables snippet support
local function make_config()
  -- enable some capabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

-------------
-- LSP setup
-------------
local function setup_servers()
  lspinstall.setup()

  local custom_configs = require("config.lsp.configs")
  local servers = lspinstall.installed_servers()

  for _, server in pairs(servers) do
    -- NOTE to self: here server is string and in lua,
    -- a dictionary is access via square brackets else
    -- it can access via dot method.
    local config = make_config()

    -- some language specific setting override
    if custom_configs[server] ~= nil then
      config = vim.tbl_deep_extend("force", config, custom_configs[server])
    end

    lspconfig[server].setup(config)

    -- validation
    local cfg = lspconfig[server]
    if not (cfg and cfg.cmd and vim.fn.executable(cfg.cmd[1]) == 1) then
      print(server .. ": cmd not found: " .. vim.inspect(cfg.cmd))
    end
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
lspinstall.post_install_hook = function()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

vim.api.nvim_command("command! LspCapabilities lua require'config.lsp.capabilities'()")
