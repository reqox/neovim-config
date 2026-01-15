return {
	"stevearc/conform.nvim",

	event = { "BufReadPre", "BufNewFile" },

	-- ШАГ 3: Настройка форматтеров
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters = {
				prettier = {
					prepend_args = {
						"--single-quote", -- 'text' вместо "text"
						"--jsx-single-quote", -- <div className='x'> вместо "x"

						"--semi", -- const x = 1; (с точкой с запятой)

						"--tab-width",
						"2", -- Отступ 2 пробела

						"--trailing-comma",
						"all", -- { a: 1, b: 2, } везде

						"--arrow-parens",
						"always", -- (x) => x

						"--print-width",
						"120", -- Максимум 120 символов
					},
				},
			},

			-- ШАГ 4: Указываем какой форматтер для каких файлов
			formatters_by_ft = {
				-- JavaScript / TypeScript / React / Next.js
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },

				-- CSS / SCSS
				css = { "prettier" },
				scss = { "prettier" },

				-- HTML
				html = { "prettier" },

				-- JSON
				json = { "prettier" },

				-- Markdown
				markdown = { "prettier" },

				-- Lua (для конфига NeoVim)
				lua = { "stylua" },

				-- SQL
				sql = { "sql_formatter" },
			},

			-- ШАГ 5: Автоформатирование при сохранении (:w)
			format_on_save = {
				timeout_ms = 500, -- Максимум 500мс на форматирование
				lsp_fallback = true, -- Если prettier не найден, использовать LSP
			},
		})

		-- ШАГ 6: Горячая клавиша для ручного форматирования (опционально)
		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range" })
	end,
}
