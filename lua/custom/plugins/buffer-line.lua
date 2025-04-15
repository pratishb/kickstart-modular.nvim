return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      local bufferline = require 'bufferline'
      bufferline.setup {
        options = {
          style_preset = bufferline.style_preset.no_italic,
          diagnostics = 'nvim_lsp',
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match 'error' and ' ' or ' '
            return ' ' .. icon .. count
          end,
          separator_style = 'slant',
          hover = {
            enabled = true,
            delay = 100,
            reveal = { 'close' },
          },
          offsets = {
            {
              filetype = 'neo-tree',
              text = '',
              text_align = 'center',
              separator = true,
            },
          },
          color_icons = true, -- whether or not to add the filetype icon highlights
          show_buffer_icons = true, -- disable filetype icons for buffers
        },
      }
    end,
  },
}
