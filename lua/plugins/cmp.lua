return {
  'hrsh7th/nvim-cmp',
  
  event = 'InsertEnter', -- Загружать только в Insert Mode
  
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',  -- Автодополнение от LSP (функции, переменные)
    'hrsh7th/cmp-buffer',    -- Автодополнение из текста в файле
    'hrsh7th/cmp-path',      -- Автодополнение путей к файлам
    'L3MON4D3/LuaSnip',      -- Движок для сниппетов
    'saadparwaiz1/cmp_luasnip', -- Интеграция LuaSnip с nvim-cmp
  },
  
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    
    cmp.setup({
      -- ШАГ 5: Подключаем движок сниппетов
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- Используем LuaSnip
        end,
      },
      
      -- ШАГ 6: Горячие клавиши для автодополнения
      mapping = cmp.mapping.preset.insert({
        -- Tab = выбрать элемент автодополнения
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true }) -- Подтвердить выбор
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump() -- Прыгнуть в сниппете
          else
            fallback() -- Обычный Tab
          end
        end, { 'i', 's' }),
        
        -- Ctrl+n / Ctrl+p = навигация по списку
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        
        -- Ctrl+Space = открыть автодополнение вручную
        ['<C-Space>'] = cmp.mapping.complete(),
        
        -- Esc = закрыть автодополнение
        ['<C-e>'] = cmp.mapping.abort(),
      }),
      
      -- ШАГ 7: Источники автодополнения (порядок = приоритет)
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },  -- 1. LSP (функции, импорты, переменные)
        { name = 'luasnip' },   -- 2. Сниппеты
        { name = 'buffer' },    -- 3. Текст из открытого файла
        { name = 'path' },      -- 4. Пути к файлам
      }),
      
      -- ШАГ 8: Внешний вид окна автодополнения
      window = {
        completion = cmp.config.window.bordered(),    -- Рамка вокруг списка
        documentation = cmp.config.window.bordered(), -- Рамка вокруг документации
      },
      
      -- ШАГ 9: Форматирование элементов списка
      formatting = {
        format = function(entry, item)
          -- Показываем откуда пришло автодополнение
          item.menu = ({
            nvim_lsp = '[LSP]',
            luasnip = '[Snippet]',
            buffer = '[Buffer]',
            path = '[Path]',
          })[entry.source.name]
          return item
        end,
      },
    })
  end,
}

