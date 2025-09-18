return {
  "saghen/blink.cmp",
  version = "1.*",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },

    completion = {
      accept = { auto_brackets = { enabled = true } },
      documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = "rounded" } },
      ghost_text = { enabled = true },
      menu = {
        border = "rounded",
        draw = {
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
          components = {
            kind_icon = {
              text = function(ctx)
                return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
              end,
            },
          },
          padding = { 0, 1 },
          treesitter = { "lsp" },
        },
      },
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
      trigger = { show_on_accept_on_trigger_character = false },
    },

    enabled = function()
      return not vim.tbl_contains({ "typr" }, vim.bo.filetype)
    end,

    keymap = {
      preset = "enter",
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_next()
          end
        end,
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_prev()
          end
        end,
        "snippet_backward",
        "fallback",
      },
    },

    -- default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, via `opts_extend`
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    cmdline = {
      enabled = true,
      keymap = { preset = "cmdline" },
      completion = {
        list = { selection = { preselect = false } },
        menu = {
          auto_show = function()
            return vim.fn.getcmdtype() == ":"
          end,
        },
        ghost_text = { enabled = true },
      },
    },

    signature = { enabled = true },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = {
    "sources.default",
  },
}
