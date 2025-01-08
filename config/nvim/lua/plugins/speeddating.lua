return {
  {
    "tpope/vim-speeddating",
    config = function()
      vim.keymap.set({ 'n', 'v' }, '<Plug>SwapItFallbackIncrement', '<Plug>SpeedDatingUp')
      vim.keymap.set({ 'n', 'v' }, '<Plug>SwapItFallbackDecrement', '<Plug>SpeedDatingDown')
    end
  }
}
