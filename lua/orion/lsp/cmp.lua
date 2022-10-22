local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
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

---------
-- Visual
----------
--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

local border_opts =
  { border = "single", winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None" }

cmp.setup({
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])

      vim_item.menu = ({
        nvim_lsp = "[L]",
        luasnip = "[S]",
        buffer = "[B]",
        path = "[P]",
      })[entry.source.name]

      -- truncating the long line
      local label = vim_item.abbr
      local truncated_label = vim.fn.strcharpart(label, 0, 30)
      if truncated_label ~= label then
        vim_item.abbr = truncated_label .. "..."
      end

      return vim_item
    end,
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
  duplicates = {
    nvim_lsp = 1,
    luasnip = 1,
    path = 1,
    buffer = 1,
  },
  -- NOTE: The order of the sources determines their order in the completion results.
  -- You can specify multiple source arrays. The sources are grouped in the
  -- order you specify, and the groups are displayed as a fallback, like chain
  -- completion.
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "nvim_lsp_signature_help" },
  }, {
    {
      name = "buffer",
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
  }),
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
  window = {
    completion = border_opts,
    documentation = border_opts,
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline", keyword_pattern = [[\!\@<!\w*]] },
  }),
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "buffer" },
  }),
})

-- luasnipe config
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snips" } })
