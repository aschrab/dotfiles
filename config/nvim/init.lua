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

-- Shorter time before updating swapfile and triggering CursorHold events
vim.opt.updatetime=200

vim.g.mapleader = ','

vim.cmd.colorscheme('vividchalk')

vim.opt.title = true
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*" },
  callback = function()
    vim.opt.titlestring = "Vim@" -- FIXME
  end

})

vim.g.python3_host_prog = '/Users/ats/.local/venv/nvim/bin/python3'

vim.api.nvim_set_keymap('c', '%%', "<C-R>=expand('%:h').'/'<CR>", {
    noremap = true,
    desc = "In command line, expand %% to the directory containing the current file"
})

local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand
-- Highlight on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '1000' })
  end
})

require("config.lazy")
