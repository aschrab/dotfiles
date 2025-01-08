return {
  {
    "SirVer/ultisnips",
    cond = function()
      return vim.g.python3_host_prog
    end,
    init = function()
      vim.g.UltiSnipsExpandTrigger = '<C-X><C-S>'
      vim.g.UltiSnipsJumpForwardTrigger = '<C-j>'
      vim.g.UltiSnipsJumpBackwardTrigger = '<C-k>'
    end
  }
}
