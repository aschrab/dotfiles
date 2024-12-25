return {
  {
    "Raimondi/delimitMate",
    init = function()
      vim.g.delimitMate_jump_expansion = 1
      vim.g.delimitMate_expand_space = 1
      vim.g.delimitMate_expand_cr = 2
      vim.g.delimitMate_balance_matchpairs = 1
      vim.g.delimitMate_matchpairs = '(:),[:],{:}'
    end
  }
}
