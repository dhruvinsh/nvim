return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "petertriho/cmp-git",

    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "windwp/nvim-autopairs",
  },
  config = function()
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
        -- { name = "copilot" },
        { name = "luasnip" },
        { name = "path" },
      }, {
        { name = "buffer" },
      }),
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(_, item)
          local icon = ui.lspkind[item.kind]

          icon = " " .. icon .. " "
          item.menu = "    (" .. item.kind .. ")"
          item.kind = icon

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
        completion = {
          col_offset = -3,
          side_padding = 0,
          scrollbar = false,
        },
        documentation = cmp.config.window.bordered({
          max_height = math.floor(vim.o.lines * 0.5),
          max_width = math.floor(vim.o.columns * 0.4),
        }),
      },
    })

    -- some highlighting for ghost text
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

    -- Inside a snippet, use backspace to remove the placeholder.
    vim.keymap.set("s", "<BS>", "<C-O>s")
  end,
}
