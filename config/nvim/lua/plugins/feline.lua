return {
  { "nvim-tree/nvim-web-devicons" },
  {
    "famiu/feline.nvim",
    config = function()
      require('feline').setup()
      -- require('feline').winbar.setup()
    end
  }
}
