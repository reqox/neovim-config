return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    disable_netrw = true,
    view = {
      adaptive_size = false,
      width = 30,
    },
    filters = {
      dotfiles = false,
    },
  },
  keys = {
    {
      '<leader>e',
      '<cmd>NvimTreeToggle<CR>',
    },
  },
}
