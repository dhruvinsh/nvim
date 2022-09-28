local status_ok, orgmode = pcall(require, "orgmode")

if status_ok then
  orgmode.setup_ts_grammar()
  orgmode.setup({
    org_agenda_files = { "~/Documents/org" },
    org_default_notes_file = "~/Documents/org/refile.org",
  })
end
