-- lua dev need to setup befor lsp
local status_ok, lua_dev = pcall(require, "lua-dev")
if status_ok then
  lua_dev.setup()
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

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
    if vim.lsp.buf.format then
      vim.lsp.buf.format({ async = true })
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, { desc = "Format current buffer with LSP" })
end
vim.keymap.set("n", "<leader>bf", "<cmd>Format <CR>", { desc = "[F]ormat" })

-- nvim-cmp supports additional completion capabilities
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Setup mason so it can manage external tooling
require("mason").setup()

-- Enable the following language servers
local servers = { "clangd", "rust_analyzer", "pyright", "tsserver", "sumneko_lua" }

-- Ensure the servers above are installed
require("mason-lspconfig").setup({
  ensure_installed = servers,
})

for _, lsp in ipairs(servers) do
  require("lspconfig")[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

-- Example custom configuration for lua
--
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("lspconfig").sumneko_lua.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
})

-- nvim-cmp setup
local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol",
      maxwidth = 50,
      ellipsis_char = "...",
    }),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif require("neogen").jumpable() then
        require("neogen").jump_next()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      elseif require("neogen").jumpable(true) then
        require("neogen").jump_prev()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "nvim_lua" },
  },
})

-- luasnipe config
require("luasnip.loaders.from_vscode").lazy_load()

-- nvim-autopairs and nvim-cmp <CR> mapping
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())