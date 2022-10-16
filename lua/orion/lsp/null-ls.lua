local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    -- webdev stuff
    formatting.prettier,

    -- lua
    formatting.stylua,
    diagnostics.selene,

    -- python
    formatting.black,
    formatting.isort,
    diagnostics.mypy,
    diagnostics.pylint,

    -- Shell
    formatting.shfmt,
    diagnostics.shellcheck,
  },
})
