local status_ok, null_ls = pcall(require, "null-ls")

if status_ok then
  local nb = require("null-ls").builtins
  null_ls.setup({
    debug = true,
    sources = {
      -- webdev stuff
      nb.formatting.prettier,

      -- Lua
      nb.formatting.stylua,
      nb.diagnostics.selene,

      -- Shell
      nb.formatting.shfmt,
      nb.diagnostics.shellcheck,

      -- python
      nb.formatting.black,
      nb.formatting.isort,
      nb.diagnostics.mypy,
      nb.diagnostics.pylint,
    },
  })
end
