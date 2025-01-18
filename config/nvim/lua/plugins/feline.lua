local component = {}

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

local shortenPath = function(path)
  if path == '' then return '(No name)' end

  -- Replace fugitive info with just `git:`
  path = path:gsub('^fugitive://.*%.git//', 'git:')
  path = path:gsub('^git:%x+/', 'git:')

  -- Convert to be relative to current dir
  path = vim.fn.fnamemodify(path, ':~:.')

  return path
end

return {
  { "nvim-tree/nvim-web-devicons" },
  {
    "aschrab/feline.nvim",
    -- dir = "/home/ats/vc/oss/feline.nvim",
    config = function()
      local components = {
        active = {
          {
            component.vi_mode,
            {
              provider = {
                name = 'file_info',
                opts = { type = shortenPath }
              },
              icon = '',
              left_sep = { 'slant_left' },
              right_sep = { 'slant_right' },
              hl = { bg = 'oceanblue' },
            },
            { hl = { bg = 'black' } }
          },
          {
            {
              provider = { name = 'file_type', opts = { case = 'lowercase', filetype_icon = true } },
              hl = { fg = 'skyblue' },
              left_sep = { 'slant_left_2' },
              right_sep = { 'slant_right_2' },
            },
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
            unpack(git),
            {
              -- cursor position
              provider = function()
                return '%3l/%L»%-3v'
              end,
              hl = { bg = 'oceanblue' },
              left_sep = 'left_filled',
            },
          }
        },
        inactive = {
          {
            {
              provider = {
                name = 'file_info',
                opts = { type = shortenPath }
              },
              left_sep = { 'slant_left' },
              right_sep = { 'slant_right' },
            },
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
