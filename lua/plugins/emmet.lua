return {
	-- ШАГ 1: Плагин Emmet для NeoVim
	"olrtg/nvim-emmet",

	-- ШАГ 2: Загружать только для HTML/CSS/JS/JSX файлов
	ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },

	-- ШАГ 3: Настройка
	config = function()
		-- По умолчанию работает на Ctrl+Y + ,
		-- Можно настроить свою клавишу:
		vim.keymap.set({ "n", "i" }, "<C-e>", require("nvim-emmet").wrap_with_abbreviation, {
			desc = "Emmet expand",
		})
	end,
}
