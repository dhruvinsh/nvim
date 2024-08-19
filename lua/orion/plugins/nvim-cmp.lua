return {
  "hrsh7th/nvim-cmp",
  version = false,
  event = { "InsertEnter" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp",
      dependencies = {
        {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_vscode").load({ paths = "./snippets" })
          end,
        },
      },
      opts = function()
        local types = require("luasnip.util.types")

        return {
          history = true,
          delete_check_events = "TextChanged",
          ext_opts = {
            [types.insertNode] = {
              active = {
                hl_group = "Boolean",
              },
              visited = {
                hl_group = "Changed",
              },
              passive = {
                hl_group = "Error",
              },
              unvisited = {
                virt_text = { { "|", "Conceal" } },
                virt_text_pos = "inline",
              },
            },
            [types.exitNode] = {
              unvisited = {
                virt_text = { { "|", "Conceal" } },
                virt_text_pos = "inline",
              },
            },
          },
        }
      end,
    },
  },
  opts = function(_, opts)
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()
    local luasnip = require("luasnip")

    local winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None"

    --
    -- Merge source from other distributed CMP configs
    --
    local sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "luasnip" },
    }, {
      {
        name = "buffer",
        keyword_length = 3,
        option = {
          get_bufnrs = function()
            return vim
              .iter(vim.api.nvim_list_wins())
              :map(function(win)
                return vim.api.nvim_win_get_buf(win)
              end)
              :totable()
          end,
        },
      },
    })
    for _, src in ipairs(opts.sources) do
      table.insert(sources, src)
    end

    return {
      preselect = cmp.PreselectMode.None,

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      --
      -- Keymaps
      --
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<cr>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
        }),
        ["/"] = cmp.mapping.close(),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      --
      -- UI
      --
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(_, vim_item)
          local symbols = require("utils.ui").symbols
          local MAX_ABBR_WIDTH, MAX_MENU_WIDTH = 25, 30
          local ellipsis = require("utils.ui").misc.ellipsis

          -- Add the icon.
          vim_item.kind = (symbols[vim_item.kind] or symbols.Text) .. " " .. (vim_item.kind or "Text")

          -- Truncate the label.
          if vim.api.nvim_strwidth(vim_item.abbr) > MAX_ABBR_WIDTH then
            vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0, MAX_ABBR_WIDTH) .. ellipsis
          end

          -- Truncate the description part.
          if vim.api.nvim_strwidth(vim_item.menu or "") > MAX_MENU_WIDTH then
            vim_item.menu = vim.fn.strcharpart(vim_item.menu, 0, MAX_MENU_WIDTH) .. ellipsis
          end

          return vim_item
        end,
      },
      window = {
        completion = {
          border = "rounded",
          winhighlight = winhighlight,
          scrollbar = true,
        },
        documentation = {
          border = "rounded",
          winhighlight = winhighlight,
          max_height = math.floor(vim.o.lines * 0.5),
          max_width = math.floor(vim.o.columns * 0.4),
        },
      },

      --
      -- Completion Sources
      --
      sources = sources,
      sorting = defaults.sorting,
    }
  end,
  config = function(_, opts)
    require("cmp").setup(opts)
  end,
}
