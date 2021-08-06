vim.g.dashboard_default_executive = "telescope"

vim.cmd "let packages = len(globpath('~/.local/share/lunarvim/site/pack/packer/start', '*', 0, 1))"
vim.api.nvim_exec([[
    let g:dashboard_custom_footer = ['Loaded '..packages..' plugins ']
]],
false)
