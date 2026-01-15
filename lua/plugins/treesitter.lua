return {
  -- Главный плагин для подсветки синтаксиса
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = 'BufReadPost',
  opts = {
    -- Включаем подсветку синтаксиса
    highlight = {
      enable = true,
      -- Указываем, какие буферы нужно игнорировать
      disable = {},
    },
    -- Устанавливаем языки, которые будут автоматически установлены
    ensure_installed = {
      'lua',
      'javascript',
      'typescript',
      'html',
      'css',
      'json',
      'yaml',
      'markdown',
      'markdown_inline',
      'vim',
      'python',
      'c',
      'cpp',
      'vue',
      'typescriptreact',
    },
  },
}
