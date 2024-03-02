require("mini.bufremove").setup()

local function delete_buffer()
  local delete = require("mini.bufremove").delete
  if vim.bo.modified then
    vim.ui.select({ "[Y]es", "[N]o", "[C]ancle" }, {
      prompt = ("Save changes to %q?"):format(vim.fn.bufname()),
      telescope = require("telescope.themes").get_dropdown({
        winblend = 10,
        layout_config = { height = 7 },
      }),
    }, function(choice)
      if choice == "[Y]es" then
        vim.cmd.write()
        vim.notify("Buffer saved..")
        delete(0)
      elseif choice == "[N]o" then
        vim.notify("Buffer discarded..")
        delete(0, true)
      end
    end)
  else
    delete(0)
  end
end

vim.keymap.set("n", "<leader>bd", delete_buffer, { desc = "Delete" })
