local M = {}

M.servers = {
  lua_ls = {
    on_init = function(client)
      local path = client.workspace_folders and client.workspace_folders[1] and client.workspace_folders[1].name
      if not path or not (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc")) then
        client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                "${3rd}/luv/library",
              },
            },
          },
        })
        client.notify(vim.lsp.protocol.Methods.workspace_didChangeConfiguration, { settings = client.config.settings })
      end
      return true
    end,
    settings = {
      Lua = {
        format = { enable = true },
        hint = {
          enable = true,
          arrayIndex = "Disable",
        },
        completion = { callSnippet = "Replace" },
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  },

  basedpyright = {},

  ruff = {},

  bashls = {},

  jsonls = {
    settings = {
      validate = { enable = true },
      format = { enable = true },
    },
    on_new_config = function(config)
      -- refer: https://github.com/b0o/SchemaStore.nvim
      config.settings.json.schemas = config.settings.json.schemas or {}
      vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
    end,
  },

  taplo = {},

  yamlls = {
    settings = {
      yaml = {
        schemaStore = { enable = false, url = "" },
      },
    },
    on_new_config = function(config)
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
