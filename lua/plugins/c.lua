return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      ---@diagnostic disable: missing-parameter
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, {
        "clang-format",
        "clangd",
      })
    end,
  },
}
