---------------------------------------------
-- Some custom settings override lives here
---------------------------------------------

local M = {}

-- utils
local check_executable = function(executable)
  if vim.fn.executable(executable) == 1 then
    return true
  end
  return false
  end

-- NOTE: All key values needs to match with what lspinstall provides as server
-------------------
-- LUA
-------------------
M.lua = {
  settings = {
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
  },
}

-------------------
-- EFM
-------------------
-- lua dependencies
local stylua = { formatCommand = "stylua -", formatStdin = true }
local selene = {
  lintCommand = "selene --display-style quiet -",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %tarning%m", "%f:%l:%c: %tarning%m" },
}
local lua_fmt = {stylua, selene}
-- python dependencies
local black = { formatCommand = "black --quiet -", formatStdin = true }
local isort = { formatCommand = "isort --quiet -", formatStdin = true }
local python_fmt = {}
if (check_executable("black") and check_executable("isort")) then
  python_fmt = {black, isort}
end

M.efm = {
  init_options = { documentFormatting = true },
  settings = {
    -- we can use .project to declare directory as root project directory
    rootMarkers = { "package.json", ".git", ".project" },
    languages = {
      lua = lua_fmt,
      python = python_fmt,
    }
  },
}
-- efm require filetypes as well,
M.efm.filetypes = {}
for ft, _ in pairs(M.efm.settings.languages) do
  table.insert(M.efm.filetypes, ft)
end

return M
