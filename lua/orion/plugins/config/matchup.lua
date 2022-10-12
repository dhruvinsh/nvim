local status_ok, _ = pcall(require, "matchup")

if not status_ok then
  return
end

local tconfig_status_ok, tconfig = pcall(require, "nvim-treesitter.configs")

if not tconfig_status_ok then
  return
end

tconfig.setup({
  matchup = {
    enable = true,
  },
})
