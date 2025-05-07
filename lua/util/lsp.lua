local M = {}

---@class ServerSpec
---@field capabilities? table override some of the lsp capabilities
---@field on_init? function override on-init function for lsp
---@field settings? table override some lsp specific settings
---@field keymaps? function override/add some lsp specific keymaps

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
        linters = {
          SentenceCapitalization = false,
        },
      },
    },
  },

  --
  -- html
  --
  html = {},

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
  },
}

---@param packages table<string> list of tools name that need to install
M.mason_pkg_installer = function(packages)
  -- HACK: in order to fix the first package installation need to setup mason and use mason-registry refresh
  -- https://github.com/williamboman/mason.nvim/issues/1133#issuecomment-1527888695
  local mr = require("mason-registry")

  mr.refresh(function(success)
    if not success then
      vim.notify("Not able to refresh mason registry", vim.log.levels.ERROR)
      return
    end

    for _, tool in ipairs(packages) do
      local p = mr.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end
  end)
end

return M
