if not os.getenv('XDG_CONFIG_HOME') or os.getenv('XDG_CONFIG_HOME') == '' then
  vim.cmd [[source $HOME/.config/nvim/vimrc.vim]]
else
  vim.cmd [[source $XDG_CONFIG_HOME/nvim/vimrc.vim]]
end

require('cmp-setup')
require('lsp-setup')
