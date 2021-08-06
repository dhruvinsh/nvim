---------------------------------------------
-- Some custom settings override lives here
---------------------------------------------

local M = {}

-- NOTE: All key values needs to match with what lspinstall provides
M.lua = {
  Lua = {
    runtime = {
      -- LuaJIT in the case of Neovim
      version = 'LuaJIT',
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = {'vim'},
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = vim.api.nvim_get_runtime_file("", true)
    },
    telemetry = {
      enable = true
    },
  },
}

return M
