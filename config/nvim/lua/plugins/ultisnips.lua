return {
  {
    "SirVer/ultisnips",
    enabled = function()
      return true
      -- return vim.g.loaded_python3_provider == 1
    end,
    init = function()
      vim.g.UltiSnipsExpandTrigger = '<C-X><C-S>'
      vim.g.UltiSnipsJumpForwardTrigger = '<C-j>'
      vim.g.UltiSnipsJumpBackwardTrigger = '<C-k>'
    end
  }
}
