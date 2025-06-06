local M = {}

-- TODO: take a look at mason-lspconfig.nvim to create this mappings
M.lsp_mappings = {
  lua_ls = "lua-language-server",
  bashls = "bash-language-server",
  harper_ls = "harper-ls",
  html = "html-lsp",
  jsonls = "json-lsp",
  rust_analyzer = "rust-analyzer",
  yamlls = "yaml-language-server",
}

---@param packages table<string> list of tools name that need to install
M.mason_pkg_installer = function(packages)
  -- HACK: in order to fix the first package installation need to setup mason and use mason-registry refresh
  -- https://github.com/williamboman/mason.nvim/issues/1133#issuecomment-1527888695
  local mr = require("mason-registry")

  mr.refresh(vim.schedule_wrap(function(success)
    if not success then
      vim.notify("Not able to refresh mason registry", vim.log.levels.ERROR)
      return
    end

    for _, tool in ipairs(packages) do
      tool = M.lsp_mappings[tool] or tool
      local p = mr.get_package(tool)

      if not p:is_installed() and not p:is_installing() then
        p:install(
          {},
          vim.schedule_wrap(function(ok, err)
            if ok then
              vim.notify(string.format("✅ Installed %s...", p.name), vim.log.levels.INFO, { title = "Mason" })
            else
              vim.notify(
                string.format("❌ Failed to install %s: %s", p.name, err),
                vim.log.levels.ERROR,
                { title = "Mason" }
              )
            end
          end)
        )
      end
    end
  end))
end

return M
