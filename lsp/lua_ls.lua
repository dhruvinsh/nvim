---@param name string plugin name
---@param trailing_path string? optional path to append to the plugin's lua directory
local stdpath = function(name, trailing_path)
  trailing_path = trailing_path or "/lua"
  return vim.fn.stdpath("data") .. "/lazy/" .. name .. trailing_path
end

---@type vim.lsp.Config
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc" },
  settings = {
    Lua = {
      completion = { callSnippet = "Replace" },
      diagnostics = { globals = { "vim" } },
      format = { enable = false },
      hint = { enable = true, arrayIndex = "Disable" },
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
          -- Runtime and builtin libraries.
          "$VIMRUNTIME/lua",
          "${3rd}/luv/library",
          -- Extra configuration helpers.
          "?.lua",
          "?/?.lua",
          -- Include some plugins for API completion.
          stdpath("blink.cmp"),
          stdpath("catppuccin"),
          stdpath("codecompanion.nvim"),
          stdpath("conform.nvim"),
          stdpath("fastaction.nvim"),
          stdpath("fzf-lua"),
          stdpath("gitsigns.nvim"),
          stdpath("grug-far.nvim"),
          stdpath("lazy.nvim"),
          stdpath("mcphub.nvim"),
          stdpath("mini.ai"),
          stdpath("mini.bufremove"),
          stdpath("mini.files"),
          stdpath("nvim-autopairs"),
          stdpath("nvim-treesitter-context"),
          stdpath("overseer.nvim", "/lua/overseer/"),
          stdpath("snacks.nvim"),
          stdpath("toggleterm.nvim"),
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
