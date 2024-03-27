require("neodev").setup()
require("neoconf").setup()
require("fidget").setup({})

----------------------------
--- Nicer UI for the LSP ---
----------------------------
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

local servers = {
  bashls = {}, -- bash, sh
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        completion = { callSnippet = "Replace" },
        telemetry = { enable = false },
      },
    },
  },
  marksman = {}, -- markdown
  basedpyright = {
    settings = {
      basedpyright = {
        typeCheckingMode = "standard",
      },
    },
  }, -- python
  ruff_lsp = {}, -- python
  taplo = {}, -- toml
  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          -- You must disable built-in schemaStore support if you want to use
          -- this plugin and its advanced options like `ignore`.
          enable = false,
          -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
          url = "",
        },
        schemas = require("schemastore").yaml.schemas(),
      },
    },
  },
}

local on_attach = function(client, bufnr)
  ---@param keys string
  ---@param func function | string
  ---@param desc? string
  ---@param mode? string
  local nmap = function(keys, func, desc, mode)
    if desc then desc = "LSP: " .. desc end

    if mode then
      vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
    else
      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end
  end

  -- code things
  nmap("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
  nmap("gr", require("telescope.builtin").lsp_references, "Goto References")
  nmap("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
  nmap("gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, "Type Definition")
  nmap("<leader>cr", vim.lsp.buf.rename, "Rename")
  nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
  nmap("<leader>cl", ":LspInfo <cr>", "Info")

  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")

  nmap("K", vim.lsp.buf.hover, "Hover")
  nmap("gk", vim.lsp.buf.signature_help, "Hover")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation", "i")

  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
  nmap("<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "Workspace List Folders")

  ----------------------------
  -- Server specific feature
  ----------------------------
  if client.supports_method("textDocument/declaration") then nmap("gD", vim.lsp.buf.declaration, "Goto Declaration") end
  if client.supports_method("textDocument/inlayHint") then vim.lsp.inlay_hint.enable(bufnr, true) end
  if client.supports_method("textDocument/codeLens") then
    nmap("<leader>cc", vim.lsp.codelens.run, "Run Codelens")
    nmap("<leader>cC", vim.lsp.codelens.refresh, "Refresh & Display Codelens")

    vim.lsp.codelens.refresh()
    vim.api.nvim_create_autocmd(
      { "BufEnter", "CursorHold", "InsertLeave" },
      { buffer = bufnr, callback = vim.lsp.codelens.refresh }
    )
  end

  ----------------------------
  -- Server specific override
  ----------------------------
  if client.name == "ruff_lsp" then client.server_capabilities.hoverProvider = false end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- install all the valid lsp servers
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = (servers[server_name] or {}).settings,
        filetypes = (servers[server_name] or {}).filetypes,
      })
    end,
  },
})

----------------------------
-- Some keymaps
----------------------------
vim.keymap.set("n", "<leader>lc", "<cmd>ConformInfo<cr>", { desc = "Conform" })
vim.keymap.set("n", "<leader>ll", "<cmd>LspInfo<cr>", { desc = "Lsp" })
vim.keymap.set("n", "<leader>lm", "<cmd>Mason<cr>", { desc = "Mason" })
vim.keymap.set("n", "<leader>ln", "<cmd>Neoconf show<cr>", { desc = "Neoconf" })
