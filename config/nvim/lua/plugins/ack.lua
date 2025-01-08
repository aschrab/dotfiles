return {
  {
    "mileszs/ack.vim",
    init = function()
      vim.g.ackprg = 'ag --vimgrep'
    end
  }
}
