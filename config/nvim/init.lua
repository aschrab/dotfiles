vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.scrolloff = 1
vim.opt.sidescrolloff = 10

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.clipboard = 'unnamedplus'

vim.g.mapleader = ','

vim.cmd.colorscheme('vividchalk')

vim.opt.title = true
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*" },
  callback = function()
    vim.opt.titlestring = "Vim@" -- FIXME
  end

})

require("config.lazy")
