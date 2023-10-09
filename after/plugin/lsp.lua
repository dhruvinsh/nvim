local util = require("utils")

require("neodev").setup()

local mason_lspconfig = require("mason-lspconfig")

local servers = {
  pyright = {},
  ruff_lsp = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

local linter_and_formatter = {
  -- python
  "black",
  "isort",
  "mypy",
  "ruff",

  -- lua
  "stylua",

  -- markdown
  "cbfmt",
  "vale",

  -- js, html, markdown and lot of others
  "prettierd",
}

-- NOTE: ARM selene is not avaiabel with mason, but brew supports it
if not util.is_mac then
  table.insert(linter_and_formatter, "selene")
end

-- install all the the valid linter and formatter
local mr = require("mason-registry")
for _, tool in ipairs(linter_and_formatter) do
  local p = mr.get_package(tool)
  if not p:is_installed() then
    p:install()
  end
end

local on_attach = function(_, bufnr)
  ---@param keys string
  ---@param func function | string
  ---@param desc? string
  ---@param mode? string
  local nmap = function(keys, func, desc, mode)
    if desc then
      desc = "LSP: " .. desc
    end

    if mode then
      vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
    else
      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end
  end

  -- diagnostics
  nmap("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
  nmap("]d", vim.diagnostic.goto_next, "Next Diagnostic")
  nmap("<leader>cd", vim.diagnostic.open_float, "Diagnostic message")

  -- code things
  nmap("gd", vim.lsp.buf.definition, "Goto Definition")
  nmap("gr", require("telescope.builtin").lsp_references, "Goto References")
  nmap("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
  nmap("gy", function()
    require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
  end, "Type Definition")
  nmap("<leader>cr", vim.lsp.buf.rename, "Rename")
  nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
  nmap("<leader>cl", ":LspInfo <cr>", "Info")

  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")

  nmap("K", vim.lsp.buf.hover, "Hover")
  nmap("gk", vim.lsp.buf.signature_help, "Hover")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation", "i")

  nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "Workspace List Folders")

  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- install all the valid lsp servers
mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
  -- ensure_installed = vim.tbl_extend("keep", vim.tbl_keys(servers), lint_and_formatter),
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    })
  end,
})

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete({}),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
})

----------------------------------------------------
-- Formatter
----------------------------------------------------
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    markdown = { "cbfmt", "prettierd" },
    python = { "isort", "black" },
  },
})

vim.opt.formatexpr = "v:lua.require('conform').formatexpr()"

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

----------------------------------------------------
-- Linter
----------------------------------------------------
local lint = require("lint")
lint.linters_by_ft = {
  lua = { "selene" },
  markdown = { "vale" },
  python = { "ruff", "mypy" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
