-- CREDITS: defaults.nvim, folke/dot, LunarVim, lspinstall
local lspconfig = require("lspconfig")
local lspinstall = require("lspinstall")


-- TODO: some cool autocmd to look at
-- Set autocommands conditional on server_capabilities
-- if client.resolved_capabilities.document_highlight then
--   vim.api.nvim_exec([[
--   augroup lsp_document_highlight
--   autocmd! * <buffer>
--   autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--   autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--   augroup END
--   ]], false)
-- end


-- keybindings
local function add_lsp_buffer_keybindings(bufnr)
  -- Few keymaping
  local wk = require "which-key"
  local keys = {
    ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show hover" },
    ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
    ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto declaration" },
    ["gr"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "Goto references" },
    ["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto implementation" },
    ["gs"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "show signature help" },
    ["gp"] = { "<cmd>lua require'lsp.peek'.Peek('definition')<CR>", "Peek definition" },
    ["gl"] = {
      "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false, border = 'single' })<CR>",
      "Show line diagnostics",
    },
  }
  wk.register(keys, { mode = "n", buffer = bufnr })

  -- TODO: something to look at later for conditional keybinding
  -- Set some keybinds conditional on server capabilities
  -- if client.resolved_capabilities.document_formatting then
  --   buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  -- elseif client.resolved_capabilities.document_range_formatting then
  --   buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  -- end

end

-- enable on_attach
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  add_lsp_buffer_keybindings(bufnr)
end

-- pre-setup config maker
-- config that activates keymaps and enables snippet support
local function make_config()
  -- enable some capabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
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

  local custom_settings = require("config.lsp.settings")
  local servers = lspinstall.installed_servers()

  for _, server in pairs(servers) do
    -- NOTE to self: here server is string and in lua,
    -- a dictionary is access via square brackets else
    -- it can access via dot method.
    local config = make_config()

    -- some language specific setting override
    if custom_settings[server] ~= nil then
      config.settings = custom_settings[server]
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
lspinstall.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end


--------------------------
-- LSP management keymaps
--------------------------
vim.api.nvim_set_keymap('n', '<leader>lr', ':LspRestart<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>li', ':LspInfo<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ls', ':LspStart<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lt', ':LspStop<CR>', { noremap = true, silent = true })
