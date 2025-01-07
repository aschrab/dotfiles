vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.scrolloff = 1
vim.opt.sidescrolloff = 10

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.infercase = true
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

vim.opt.shada = "!,s1,%,'20,f1,c,h,<0,r/tmp,r/media"
vim.opt.shiftwidth = 0 -- use tabstop
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.title = true
vim.opt.showmatch = true
vim.opt.showmode = false

vim.opt.formatoptions:append('2r')
vim.opt.nrformats = 'hex'
vim.opt.matchpairs = '(:),{:},[:],<:>'
vim.opt.fileformats = 'unix,dos,mac'
vim.opt.fixeol = false
vim.opt.wildignore:append('*.o,*~,*.pyc')
vim.opt.wildignorecase = true
vim.opt.completeopt = 'longest,menuone,preview'
vim.opt.spelloptions:append('camel')
vim.opt.tags = 'tags,TAGS,./tags;,./TAGS;'

vim.opt.diffopt:append('vertical,algorithm:patience,indent-heuristic,linematch:60')
vim.opt.isfname:remove('=')

vim.opt.listchars:append('tab:→·,trail:∙,nbsp:_')
vim.opt.listchars:append('precedes:«,extends:»') -- Color controlled by hl-NonText
vim.opt.list = true

vim.opt.showbreak = '↪'
vim.opt.cinoptions:append('l1,(0,t0')

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
