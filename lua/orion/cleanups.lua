-- Cleanups some mason packages

local mason_pkgs_to_uninstall = { "markdownlint" }

require("util.lsp").mason_pkg_uninsaller(mason_pkgs_to_uninstall)
