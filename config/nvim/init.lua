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

vim.opt.termguicolors = true
vim.cmd.colorscheme('vividchalk')

vim.opt.title = true
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*" },
  callback = function()
    vim.opt.titlestring = "Vim@" -- FIXME
  end

})


local uv = vim.uv
-- Before nvim 0.10 need to look to vim.loop for the uv module
if (uv == nil) then uv = vim.loop end

if (uv and uv.fs_stat) then
  local python = os.getenv('HOME') .. '/.local/venv/nvim/bin/python3'
  local stat, err, name = uv.fs_stat(python)
  if (stat) then
    vim.g.python3_host_prog = python
  end
end

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

autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '.envrc',
  callback = function()
    vim.opt.filetype = 'bash'
  end
})

require("config.lazy")
