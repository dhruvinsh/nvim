local status_ok, iom = pcall(require, "indent-o-matic")

if status_ok then
  iom.setup({
    -- The values indicated here are the defaults
    -- Number of lines without indentation before giving up (use -1 for infinite)
    max_lines = 2048,
    -- Space indentations that should be detected
    standard_widths = { 2, 4, 8 },
    -- Skip multi-line comments and strings (more accurate detection but less performant)
    skip_multiline = true,

    -- force lua to 2 spaces
    filetype_lua = {
      standard_widths = { 2 },
    },
  })
end