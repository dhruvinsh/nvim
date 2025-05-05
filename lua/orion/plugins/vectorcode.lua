return vim.fn.executable("vectorcode") == 1
    and {
      "Davidyz/VectorCode",
      version = "*",
      build = "uv tool install -U vectorcode",
      dependencies = { "nvim-lua/plenary.nvim" },
      cmd = "VectorCode",
      keys = {
        { "<leader>av", "<cmd>VectorCode<cr>", desc = "VectorCode" },
      },
    }
  or {}
