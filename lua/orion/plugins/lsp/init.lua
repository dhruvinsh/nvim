local util = require("orion.util")

return {

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim", opts = {} },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          return util.has("nvim-cmp")
        end,
      },
    },
    opts = {
      autoformat = true,
      capabilities = {}, -- some global capabilities
      servers = {
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        pyright = {},
      },
    },
    config = function(_, opts)
      local handlers = require("orion.plugins.lsp.handlers")

      local setup = function(server)
        local server_opts = vim.tbl_deep_extend("force", {
          on_attach = handlers.on_attach,
          capabilities = handlers.capabilities(opts),
        }, opts.servers[server] or {})

        require("lspconfig")[server].setup(server_opts)
      end

      -- manage global and project-local settings
      require("neoconf").setup()

      -- setup formatting
      require("orion.plugins.lsp.format").setup(opts)

      -- automatic lsp server installation via mason
      local ensure_installed = {} ---@type string[]
      local _, mlsp = pcall(require, "mason-lspconfig")
      for server, _ in pairs(opts.servers) do
        ensure_installed[#ensure_installed + 1] = server
      end
      mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
    end,
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
        },
      }
    end,
  },

  -- cmdline tools and lsp servers
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  -- lsp symbol navigation for lualine. This shows where
  -- in the code structure you are - within functions, classes,
  -- etc - in the statusline.
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
    end,
    opts = function()
      return {
        separator = " ",
        highlight = true,
        depth_limit = 5,
        icons = util.icons,
      }
    end,
  },
}
