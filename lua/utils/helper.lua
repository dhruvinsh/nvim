----------------------------------
-- Some common function that is
-- needed once the all the plugins
-- are install.
----------------------------------

local M = {}

---@param pkgs table
function M.mason_pkg_installer(pkgs)
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
