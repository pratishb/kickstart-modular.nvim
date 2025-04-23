-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
      {
        's1n7ax/nvim-window-picker', -- for open_with_window_picker keymaps
        version = '2.*',
        config = function()
          require('window-picker').setup {
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
                -- if the buffer type is one of following, the window will be ignored
                buftype = { 'terminal', 'quickfix' },
              },
            },
          }
        end,
      },
    },
    cmd = 'Neotree',
    keys = {
      { '\\', ':Neotree toggle<CR>', desc = 'NeoTree Toggle', silent = true },
      { '|', ':Neotree reveal<CR>', desc = 'NeoTree Reveal', silent = true },
    },
    lazy = false,
    config = function()
      -- Open the tree automatically with NeoVim, unless opening a specific file
      vim.api.nvim_create_autocmd('VimEnter', {
        pattern = '*',
        group = vim.api.nvim_create_augroup('NeotreeOnOpen', { clear = true }),
        once = true,
        callback = vim.schedule_wrap(function()
          if vim.fn.argc() == 0 then
            vim.cmd 'Neotree show'
          end
        end),
      })
      require('neo-tree').setup {
        source_selector = {
          winbar = true,
        },
        event_handlers = {
          {
            event = 'neo_tree_buffer_enter',
            handler = function()
              local hl = vim.api.nvim_get_hl(0, { name = 'Cursor' })
              hl.blend = 100
              vim.api.nvim_set_hl(0, 'Cursor', hl)
              vim.opt.guicursor:append 'a:Cursor/lCursor'
            end,
          },
          {
            event = 'neo_tree_buffer_leave',
            handler = function()
              local hl = vim.api.nvim_get_hl(0, { name = 'Cursor' })
              hl.blend = 0
              vim.api.nvim_set_hl(0, 'Cursor', hl)
              vim.opt.guicursor:remove 'a:Cursor/lCursor'
            end,
          },
        },
        popup_border_style = 'rounded',
      }
    end,
  },
}
