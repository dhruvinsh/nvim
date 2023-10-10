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
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
  }, {
    { name = "buffer" },
  }),
})

cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "git" },
  }, {
    { name = "buffer" },
  }),
})

-- TODO: implement this..
-- {
--   "hrsh7th/nvim-cmp",
--   ---@param opts cmp.ConfigSchema
--   opts = function(_, opts)
--     for _, source in ipairs(opts.sources) do
--       if source.name == "luasnip" then
--         source.option = { use_show_condition = true }
--         source.entry_filter = function()
--           local ctx = require("cmp.config.context")
--           local string_ctx = ctx.in_treesitter_capture("string") or ctx.in_syntax_group("String")
--           local comment_ctx = ctx.in_treesitter_capture("comment") or ctx.in_syntax_group("Comment")
--
--           --   Returning `true` will keep the entry, while returning `false` will remove it.
--           return not (string_ctx or comment_ctx)
--         end
--       end
--     end
--   end,
-- },
