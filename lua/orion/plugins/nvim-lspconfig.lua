return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonUpdate" },
    build = ":MasonUpdate",
    keys = {
      { "<leader>lm", "<cmd>Mason<cr>", desc = "mason" },
    },
    opts = {
      ui = {
        border = "rounded",
        width = 0.7,
        height = 0.8,
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      local lsp = require("util.lsp")

      local handlers = {
        -- default handlers for all lsp server
        ---@param sname string lsp server name
        function(sname)
          -- HACK: what if server that installed not part of `servers` list?
          local sconfig = lsp.servers[sname] or {}
          local capabilities = require("blink.cmp").get_lsp_capabilities(sconfig.capabilities, true)

          vim.lsp.config(sname, {
            on_init = sconfig.on_init,
            settings = sconfig.settings,
            capabilities = capabilities,
          })
          vim.lsp.enable(sname)

          -- handle additional keymaps
          local keymaps_func = sconfig.keymaps
          if keymaps_func ~= nil then
            vim.api.nvim_create_autocmd("LspAttach", {
              desc = "additional keympas for " .. sname,
              callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)

                if not client then
                  return
                end

                keymaps_func(args.buf)
              end,
            })
          end
        end,
      }

      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(lsp.servers),
        automatic_installation = true,
        handlers = handlers,
      })
    end,
  },
}
