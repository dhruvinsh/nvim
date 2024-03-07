local utils = require("utils")
local ui = require("utils.ui")

vim.diagnostic.config({
  severity_sort = true,
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    prefix = function(diagnostic)
      local icons = ui.diagnostics
      for d, icon in pairs(icons) do
        if diagnostic.severity == vim.diagnostic.severity[d:upper()] then return icon end
      end
    end,
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP Diagnostic",
  group = utils.augroup("lsp_diagnostic"),
  callback = function(ev)
    ---@param keys string
    ---@param func function | string
    ---@param desc? string
    ---@param mode? string
    local nmap = function(keys, func, desc, mode)
      if desc then desc = "LSP: " .. desc end

      if mode then
        vim.keymap.set(mode, keys, func, { buffer = ev.buf, desc = desc })
      else
        vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = desc })
      end
    end

    -- diagnostics
    nmap("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
    nmap("]d", vim.diagnostic.goto_next, "Next Diagnostic")
    nmap("<leader>cd", vim.diagnostic.open_float, "Diagnostic message")
  end,
})
