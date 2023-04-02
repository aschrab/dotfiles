if $XDG_CONFIG_HOME != ''
  source $XDG_CONFIG_HOME/nvim/vimrc.vim
else
  source $HOME/.config/nvim/vimrc.vim
endif

lua <<EOF
require('cmp-setup')
require('lsp-setup')
EOF
