return {
  {
    "Raimondi/delimitMate",
    init = function()
      vim.g.delimitMate_jump_expansion = 1
      vim.g.delimitMate_expand_space = 1
      vim.g.delimitMate_expand_cr = 2
      vim.g.delimitMate_balance_matchpairs = 1
      vim.g.delimitMate_matchpairs = '(:),[:],{:}'
    end,
    config = function()
      -- Hack to try to get endwise and delimitmate to play together
      -- From https://github.com/tpope/vim-endwise/issues/133#issuecomment-1087777576
      if vim.fn.maparg('<CR>', 'i') == '' then
        vim.api.nvim_set_keymap('i', '<CR>', "<Plug>delimitMateCR", {
            noremap = true,
        })
      end
    end
  }
}
