local component = {}

component.file_info = { provider = { name = 'file_info', opts = { type = 'relative-short' } } }

component.vi_mode = {
  provider = 'vi_mode',
  -- icon = '',
  right_sep = ' ',
  hl = function()
    return {
      name = require('feline.providers.vi_mode').get_mode_highlight_name(),
      fg = require('feline.providers.vi_mode').get_mode_color(),
      style = 'bold'
    }
  end,
}

component.file_type = { provider = { name = 'file_type', opts = { case = 'lowercase' } } }

local git = {
  {
    provider = 'git_branch',
    hl = { fg = 'white', bg = 'blue' },
    left_sep = 'left_rounded',
    right_sep = 'right_rounded',
  },
  { provider = 'git_diff_added', hl = { fg = 'green' } },
  { provider = 'git_diff_removed', hl = { fg = 'red' } },
  { provider = 'git_diff_changed', hl = { fg = 'oceanblue', } },
}

return {
  { "nvim-tree/nvim-web-devicons" },
  {
    "famiu/feline.nvim",
    config = function()
      local components = {
        active = {
          {
            component.vi_mode,
            component.file_info,
          },
          {
            component.file_type,
            {
              left_sep = 'left_rounded',
              right_sep = 'right_rounded',
              hl = { bg = 'yellow', fg = 'black' },
              enabled = function()
                local fenc = vim.opt.fileencoding:get()
                if fenc == '' then return false end
                if fenc == 'utf-8' then return false end
              end,
              provider = function()
                return vim.opt.fileencoding:get()
              end
            },
            {
              left_sep = 'left_rounded',
              right_sep = 'right_rounded',
              hl = { bg = 'red', fg = 'white' },
              enabled = function()
                return vim.opt.fileformat:get() ~= 'unix'
              end,
              provider = function()
                return vim.opt.fileformat:get()
              end
            },
          },
          {
            {
              -- cursor position
              provider = function()
                return '%3l/%L»%-3v'
              end
            },
            unpack(git)
          }
        },
        inactive = {
          {
            component.file_info,
          },
          {
            unpack(git)
          },
        },
      }

      require('feline').setup({
        components = components,
        theme = 'default',
      })
      -- require('feline').winbar.setup()
    end
  }
}
