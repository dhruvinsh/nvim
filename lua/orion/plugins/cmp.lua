return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "petertriho/cmp-git",
    "windwp/nvim-autopairs",
  },
  opts = function()
    local cmp = require("cmp")
    local ui = require("utils.ui")
    return {
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item(), -- default behavior is Insert
        ["<C-p>"] = cmp.mapping.select_prev_item(), -- default behavior is Insert
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<C-e>"] = cmp.mapping.close(),
        -- ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert, -- other option is Replace, lets try Insert for a change.
          select = true,
        }),
      }),
      sources = cmp.config.sources({
        -- give lsp more priority then copilot
        { name = "nvim_lsp", priority = 100 },
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
    }
  end,
  ---@param opts cmp.ConfigSchema
  config = function(_, opts)
    for _, source in ipairs(opts.sources) do
      source.group_index = source.group_index or 1
    end
    local cmp = require("cmp")

    cmp.setup(opts)

    -- fugitive autocompletion
    ---@diagnostic disable-next-line
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" },
        { name = "snippets" },
      }, {
        { name = "buffer" },
      }),
    })
    require("cmp_git").setup()

    -- some highlighting for ghost text
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

    -- Inside a snippet, use backspace to remove the placeholder.
    vim.keymap.set("s", "<BS>", "<C-O>s")
  end,
}
