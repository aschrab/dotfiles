return {
  {
    "tpope/vim-fugitive",
    init = function()
      vim.g.fugitive_legacy_commands = 0
    end
  },
  {
    "shumphrey/fugitive-gitlab.vim",
    init = function()
      vim.g.fugitive_gitlab_domains = {
        ['gitlab.av'] = 'https://gitlab.av'
      }
    end
  }
}
