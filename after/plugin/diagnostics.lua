vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP diagnostic",
  callback = function(ev)
    ---@param keys string
    ---@param func function | string
    ---@param desc? string
    local nmap = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = desc })
    end

    nmap("]d", "<cmd>lua vim.diagnostic.jump({severity=vim.diagnostic.severity.INFO, count=1})<cr>", "error")
    nmap("[d", "<cmd>lua vim.diagnostic.jump({severity=vim.diagnostic.severity.INFO, count=-1})<cr>", "error")
    nmap("<leader>cd", "<cmd>lua vim.diagnostic.open_float({source='if_many'})<cr>", "diagnostic")
  end,
})

require("util.toggle").diagnostic:map_and_register("n", "<leader>td")
