local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
  return
end

local lspkind_staus_ok, lspkind = pcall(require, "lspkind")
if not lspkind_staus_ok then
  return
end

local luasnip_staus_ok, luasnip = pcall(require, "luasnip")
if not luasnip_staus_ok then
  return
end

local neogen_status_ok, neogen = pcall(require, "neogen")
if not neogen_status_ok then
  return
end

vim.o.completeopt = "menu,menuone,noselect"

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
      elseif neogen.jumpable() then
        neogen.jump_next()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      elseif neogen.jumpable(-1) then
        neogen.jump_prev()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "buffer" },
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "rg" },
  },
})

-- luasnipe config
require("luasnip.loaders.from_vscode").lazy_load()
