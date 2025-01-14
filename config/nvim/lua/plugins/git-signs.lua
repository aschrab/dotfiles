return {
  {
    "lewis6991/gitsigns.nvim",
    init = function()
      signs = require('gitsigns')
      signs.setup({
        on_attach = function()
          vim.keymap.set('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({'[c', bang = true})
            else
              signs.nav_hunk('prev')
            end
          end)
          vim.keymap.set('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({']c', bang = true})
            else
              signs.nav_hunk('next')
            end
          end)
        end
      })
    end
  }
}
