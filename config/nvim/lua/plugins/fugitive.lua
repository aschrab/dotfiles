return {
  { "tpope/vim-fugitive" },
  {
    "shumphrey/fugitive-gitlab.vim",
    init = function()
      vim.g.fugitive_gitlab_domains = {
        ['gitlab.av'] = 'https://gitlab.av'
      }
    end
  }
}
