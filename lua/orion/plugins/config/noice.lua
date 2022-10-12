local status_ok, noice = pcall(require, "noice")

if not status_ok then
  return
end

noice.setup({
  cmdline = {
    view = "cmdline",
  },
  routes = {
    -- hide AutoSave messages
    {
      filter = {
        event = "msg_show",
        find = "AutoSave",
      },
      opts = { skip = true },
    },

    -- hide annyoing "<" message
    {
      filter = {
        event = "msg_show",
        find = "<$",
      },
      opts = { skip = true },
    },
  },
})

local telescope_status_ok, telescope = pcall(require, "telescope")

if telescope_status_ok then
  telescope.load_extension("noice")
end
