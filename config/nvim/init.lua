vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.scrolloff = 1
vim.opt.sidescrolloff = 10

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.g.mapleader = ','

vim.cmd.colorscheme('vividchalk')

require("config.lazy")
