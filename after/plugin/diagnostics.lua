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
      return icons[diagnostic.severity]
    end,
  },
  float = {
    prefix = function(diagnostic)
      local icons = ui.diagnostics
      return icons[diagnostic.severity], ""
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

-- NOTE: Diagnostic<*> command, if bang then global else local

-- :DiagnosticDisable (Local) or :DiagnosticDisable! (Global)
vim.api.nvim_create_user_command("DiagnosticDisable", function(args)
  if args.bang then
    vim.notify("Global diagnostics disable")
    vim.diagnostic.disable()
  else
    vim.notify("Local diagnostics disable")
    vim.diagnostic.disable(0)
  end
end, { desc = "Disable diagnostics", bang = true })

-- :DiagnosticEnable (Enable both, local and global)
vim.api.nvim_create_user_command("DiagnosticEnable", function()
  vim.diagnostic.enable()
  vim.notify("Diagnostics (globally) enable")
end, { desc = "Enable diagnostics" })

-- :DiagnosticToggle (Local) or :DiagnosticToggle! (Global)
vim.api.nvim_create_user_command("DiagnosticToggle", function(args)
  if vim.diagnostic.is_disabled(0) or vim.diagnostic.is_disabled() then
    vim.cmd.DiagnosticEnable()
  else
    if args.bang then
      vim.cmd("DiagnosticDisable!")
    else
      vim.cmd("DiagnosticDisable")
    end
  end
end, { desc = "Enable diagnostics", bang = true })

-- some vim keymaps
vim.keymap.set("n", "<leader>tx", function() vim.cmd("DiagnosticToggle") end, { desc = "Diagnostics Toggle (Local)" })
vim.keymap.set("n", "<leader>tX", function() vim.cmd("DiagnosticToggle!") end, { desc = "Diagnostic Toggle (Global)" })
