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
    },
    config = function()
      local lsp = require("utils.lsp")

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- default handlers for all lsp server
      local handlers = {
        ---@param sname string lsp server name
        function(sname)
          -- HACK: what if server that installed not part of `servers` list?
          if lsp.servers[sname] == nil then
            lsp.servers[sname] = {}
          end

          require("lspconfig")[sname].setup({
            on_init = lsp.servers[sname].on_init,
            settings = lsp.servers[sname].settings,
            capabilities = capabilities,
            on_new_config = lsp.servers[sname].on_new_config, -- nil or callable
          })
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