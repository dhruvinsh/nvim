-- lua dev need to setup befor lsp
-- I don't want to stop execution just because lua_dev is not loaded
local lua_dev_status_ok, lua_dev = pcall(require, "lua-dev")
if lua_dev_status_ok then
  lua_dev.setup({})
end

local status_ok, lspconfig = pcall(require, "lspconfig")

if not status_ok then
  return
end

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  -- aerial keymaps
  nmap("{", ":AerialPrev <CR>", "Jump backwards in Aerial")
  nmap("}", ":AerialNext <CR>", "Jump forwards in Aerial")
  nmap("[[", ":AerialPrevUp <CR>", "Jump up and backwards in Aerial")
  nmap("]]", ":AerialNextUp <CR>", "Jump up and forward in Aerial")

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("gr", require("telescope.builtin").lsp_references)
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader><Tab>s", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader><Tab>a", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader><Tab>r", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader><Tab>l", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  -- Create a command `:Format` local to the LSP buffer and add keymaps
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    -- vim.lsp.buf.formatting is deprecated now
    vim.lsp.buf.format({ async = true })
  end, { desc = "Format current buffer with LSP" })
end
vim.keymap.set("n", "<leader>bf", "<cmd>Format <CR>", { desc = "[F]ormat" })

-- nvim-cmp supports additional completion capabilities
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Setup mason so it can manage external tooling
require("mason").setup()

-- Enable the following language servers
local servers = {
  "clangd",
  "jsonls",
  "pyright",
  "rust_analyzer",
  "sumneko_lua",
  "tsserver",
}

-- Ensure the servers above are installed
require("mason-lspconfig").setup({
  ensure_installed = servers,
})

for _, lsp in ipairs(servers) do
  if lsp == "sumneko_lua" then
    lspconfig[lsp].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      setting = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })
  else
    lspconfig[lsp].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end
end