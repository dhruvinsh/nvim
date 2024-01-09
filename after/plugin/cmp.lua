local cmp = require("cmp")
local luasnip = require("luasnip")
local ui = require("utils.ui")

require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({
  history = true,
  delete_check_events = "TextChanged",
})

-- nvim-cmp/lua/cmp/config/
local compare = require("cmp.config.compare")

---@diagnostic disable
cmp.setup({
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  preselect = cmp.PreselectMode.None,
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete({}),
    ["<C-e>"] = cmp.mapping.close(),
    -- ["<C-e>"] = cmp.mapping.abort(),
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
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(_, item)
      local MAX_ABBR_WIDTH, MAX_MENU_WIDTH = 25, 30
      local ELLIPSIS = "…"

      -- Kind: add the icon
      if ui.kinds[item.kind] then item.kind = ui.kinds[item.kind] .. item.kind end

      -- Abbr: Truncate the label.
      if vim.api.nvim_strwidth(item.abbr) > MAX_ABBR_WIDTH then
        item.abbr = vim.fn.strcharpart(item.abbr, 0, MAX_ABBR_WIDTH) .. ELLIPSIS
      end

      -- Menu: Truncate the description part.
      if vim.api.nvim_strwidth(item.menu or "") > MAX_MENU_WIDTH then
        item.menu = vim.fn.strcharpart(item.menu, 0, MAX_MENU_WIDTH) .. ELLIPSIS
      end

      return item
    end,
  },
  experimental = {
    ghost_text = {
      hl_group = "CmpGhostText",
    },
  },
  sorting = {
    comparators = {
      compare.offset,
      compare.exact,
      compare.score,
      compare.recently_used,
      compare.locality,
      compare.kind,
      -- compare.sort_text,
      compare.length,
      compare.order,
    },
  },
  window = {
    completion = cmp.config.window.bordered({ scrollbar = true }),
    documentation = cmp.config.window.bordered({
      max_height = math.floor(vim.o.lines * 0.5),
      max_width = math.floor(vim.o.columns * 0.4),
    }),
  },
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

-- some highlighting for ghost text
vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

-- Inside a snippet, use backspace to remove the placeholder.
vim.keymap.set("s", "<BS>", "<C-O>s")
