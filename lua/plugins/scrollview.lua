return {
  {
    'dstein64/nvim-scrollview',
    dependencies = { 'lewis6991/gitsigns.nvim', config = true },
    hide_for_insert = true,
    config = function()
      vim.cmd [[let g:scrollview_mode = 'proper']]
      require('scrollview').setup {
        signs_hidden_for_insert = { 'all' },
        hide_for_insert = true,
      }
    end,
  },
}
