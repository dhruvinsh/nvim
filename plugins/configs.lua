local M = {}

M.mason =  {
    ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",

        -- python
        "pyright",

        -- web dev
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "json-lsp",

        -- shell
        "shfmt",
        "shellcheck",
    },
}

return M
