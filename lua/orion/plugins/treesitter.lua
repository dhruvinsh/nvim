local parsers = {
  "bash",
  "c",
  "devicetree",
  "diff",
  "dockerfile",
  "git_config",
  "git_rebase",
  "go",
  "gomod",
  "gosum",
  "gowork",
  "html",
  "hyprlang",
  "javascript",
  "jsdoc",
  "json",
  "json5",
  "kdl",
  "lua",
  "luadoc",
  "luap",
  "make",
  "markdown",
  "markdown_inline",
  "ninja",
  "powershell",
  "python",
  "query",
  "regex",
  "rst",
  "rust",
  "sql",
  "ssh_config",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  branch = "main",
  build = ":TSUpdate",
  -- This plugin does not support lazy loading
  lazy = false,
  config = function()
    local u = require("util")
    -- Install only missing parsers to save time on startup
    local isnt_installed = function(lang)
      return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
    end
    local to_install = vim.tbl_filter(isnt_installed, parsers)
    if #to_install > 0 then
      require("nvim-treesitter").install(to_install):wait(300000)
    end

    -- Enable per file type
    local filetypes = {}
    for _, lang in ipairs(parsers) do
      for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
        table.insert(filetypes, ft)
      end
    end
    vim.api.nvim_create_autocmd("FileType", {
      group = u.augroup("treesitter"),
      pattern = filetypes,
      callback = function(ev)
        if u.is_big_buffer(ev.buf) then
          vim.notify("Buffer is too big for treesitter, skipping...", vim.log.levels.WARN)
          return
        end
        vim.treesitter.start(ev.buf)
        -- indentation, provided by nvim-treesitter
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
  init = function()
    require("vim.treesitter.query").add_predicate("is-mise?", function(_, _, bufnr, _)
      local filepath = vim.api.nvim_buf_get_name(tonumber(bufnr) or 0)
      local filename = vim.fn.fnamemodify(filepath, ":t")
      -- mise.toml, .mise.toml, mise.<env>.toml, mise.local.toml, ...
      if filename:match("^%.?mise[%w._-]*%.toml$") then
        return true
      end
      -- directory configs: .config/mise/config.toml, mise/config.toml, mise/conf.d/*.toml
      return filepath:match("[/\\]mise[/\\]") ~= nil and filename:match("%.toml$") ~= nil
    end, { force = true, all = false })
  end,
}
