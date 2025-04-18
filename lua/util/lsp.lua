local M = {}

---@class ServerSpec
---@field capabilities? table override some of the lsp capabilities
---@field on_init? function override on-init function for lsp
---@field settings? table override some lsp specific settings
---@field keymaps? function override/add some lsp specific keymaps
---@field on_new_config? function take action when config is created

---@class OrionLspServers<T>: { [string]: T}

---@type OrionLspServers<ServerSpec>
M.servers = {
  --
  -- lua
  --
  lua_ls = {},

  --
  -- c
  --
  clangd = {},

  --
  -- python
  --
  basedpyright = {
    capabilities = {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
    },
  },

  ruff = {
    capabilities = {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = false,
        },
      },
    },
    ---@param bufnr integer
    keymaps = function(bufnr)
      vim.keymap.set("n", "<leader>co", function()
        vim.lsp.buf.code_action({
          apply = true,
          context = {
            only = { "source.organizeImports" },
            diagnostics = {},
          },
        })
      end, { desc = "sort import", buffer = bufnr })
    end,
  },

  --
  -- bash
  --
  bashls = {},

  --
  -- harper: grammar
  --
  ["harper_ls"] = {
    settings = {
      ["harper-ls"] = {
        userDictPath = vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
      },
    },
  },

  --
  -- json
  --
  jsonls = {
    settings = {
      json = {
        validate = { enable = true },
        format = { enable = true },
      },
    },
    on_new_config = function(config)
      -- HACK: for lazy loading keep it here.
      --
      -- refer: https://github.com/b0o/SchemaStore.nvim
      config.settings.json.schemas = config.settings.json.schemas or {}
      vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
    end,
  },

  --
  -- toml
  --
  taplo = {},

  --
  -- yaml
  --
  yamlls = {
    settings = {
      yaml = {
        schemaStore = { enable = false, url = "" },
      },
    },
    on_new_config = function(config)
      -- HACK: for lazy loading keep it here.
      --
      -- refer: https://github.com/b0o/SchemaStore.nvim
      config.settings.yaml.schemas = config.settings.yaml.schemas or {}
      vim.list_extend(config.settings.yaml.schemas, require("schemastore").yaml.schemas())
    end,
  },
}

---@param pkgs table list of tools name that need to install
M.mason_pkg_installer = function(pkgs)
  -- HACK: in order to fix the first package installation need to setup mason and use mason-registry refresh
  -- https://github.com/williamboman/mason.nvim/issues/1133#issuecomment-1527888695
  require("mason").setup({})
  local mr = require("mason-registry")

  mr.refresh(function()
    for _, tool in ipairs(pkgs) do
      local p = mr.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end
  end)
end

return M
