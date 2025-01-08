return {
  {
    "chrisbra/unicode.vim",
    config = function()
      vim.api.nvim_set_keymap('n', 'ga', ":UnicodeName<CR>", {
          noremap = true,
      })
    end
  },
}
