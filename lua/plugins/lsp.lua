return {
  'neovim/nvim-lspconfig',
 
  -- когда загружать?
  event = { 
    'BufReadPre', -- Перед открытием существующего файла
    'BufNewFile' -- При создании нового файла
  },

  -- зависимости (плагины, которые нужны для LSP)
  dependencies = {
    'hrsh7th/cmp-nvim-lsp', -- Связь LSP с автодополнением
  },

  -- Настройка плагина (запускается после загрузки)
  config = function()
    -- Подключаем возможности автодополнения из cmp
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local capabilities = cmp_nvim_lsp.default_capabilities()
    
    -- Горячие клавиши
    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, silent = true }
      
      -- Когда добавишь клавиши, раскомментируй:
      -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
      -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      -- vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
    end

    -- НОВЫЙ API: Настройка серверов через цикл
    local servers = { 'ts_ls', 'html', 'cssls', 'jsonls', 'sqlls' }
    for _, server in ipairs(servers) do
      vim.lsp.config(server, {
        cmd = vim.lsp.config[server].cmd, -- Команда запуска сервера (авто)
        root_markers = vim.lsp.config[server].root_markers, -- Корень проекта (авто)
        capabilities = capabilities,
      })
      
      -- Включаем сервер и передаём on_attach
      vim.lsp.enable(server)
      
      -- Устанавливаем autocmd для on_attach
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == server then
            on_attach(client, args.buf)
          end
        end,
      })
    end

    -- Lua отдельно (с особыми настройками)
    vim.lsp.config('lua_ls', {
      cmd = vim.lsp.config.lua_ls.cmd,
      root_markers = vim.lsp.config.lua_ls.root_markers,
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = { globals = { 'vim' } },
        },
      },
    })
    
    vim.lsp.enable('lua_ls')
    
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == 'lua_ls' then
          on_attach(client, args.buf)
        end
      end,
    })
  end
}

