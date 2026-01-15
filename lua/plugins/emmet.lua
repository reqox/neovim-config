return {
	-- ШАГ 1: Классический Emmet для Vim (работает как в VSCode)
	"mattn/emmet-vim",

	-- ШАГ 2: Загружать только для HTML/CSS/JS/JSX файлов
	ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },

	-- ШАГ 3: Настройка
	init = function()
		-- Включить Emmet только в Insert mode
		vim.g.user_emmet_mode = "i"

		-- Работает на Ctrl+Y потом запятая (по умолчанию)
		-- Меняем на просто Ctrl+E
		-- vim.g.user_emmet_leader_key = '<C-e>'

		-- Настройки для React (className вместо class)
		vim.g.user_emmet_settings = {
			javascript = {
				extends = "jsx",
			},
			typescript = {
				extends = "tsx",
			},
		}
	end,
}
