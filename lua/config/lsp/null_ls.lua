local M = {}

M.setup = function(options)
  local nls = require("null-ls")
  nls.setup({
    debounce = 150,
    save_after_format = false,
    sources = {
      nls.builtins.formatting.black,
      nls.builtins.formatting.eslint_d,
      nls.builtins.formatting.fixjson.with({ filetypes = { "jsonc" } }),
      nls.builtins.formatting.isort,
      nls.builtins.formatting.prettierd,
      nls.builtins.formatting.stylua,
      nls.builtins.diagnostics.markdownlint,
      nls.builtins.diagnostics.mypy,
      nls.builtins.diagnostics.pylint,
      nls.builtins.diagnostics.selene,
      nls.builtins.diagnostics.shellcheck,
      nls.builtins.code_actions.gitsigns.with({
        condition = function(utils)
          return utils.root_has_file({ ".git" })
        end,
      }),
      nls.builtins.code_actions.refactoring,
    },
    on_attach = options.on_attach,
    root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".nvim.settings.json", ".git", ".projectile", "Pipenv"),
  })
end

M.has_formatter = function(ft)
  local sources = require("null-ls.sources")
  local available = sources.get_available(ft, "NULL_LS_FORMATTING")
  return #available > 0
end

return M
