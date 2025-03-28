vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP diagnostic",
  callback = function(ev)
    ---@param keys string
    ---@param func function | string
    ---@param desc? string
    local nmap = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = desc })
    end

    nmap("[d", vim.diagnostic.get_prev, "diagnostic")
    nmap("]d", vim.diagnostic.get_next, "diagnostic")
    nmap("[e", "<cmd>lua vim.diagnostic.goto_prev({severity=vim.diagnostic.severity.ERROR})<cr>", "error")
    nmap("[e", "<cmd>lua vim.diagnostic.goto_next({severity=vim.diagnostic.severity.ERROR})<cr>", "error")
    nmap("<leader>cd", "<cmd>lua vim.diagnostic.open_float({source='if_many'})<cr>", "diagnostic")
  end,
})

vim.keymap.set("n", "<leader>td", "<cmd>lua require('util.toggle').diagnostic:toggle()<cr>", { desc = "diagnostic" })
