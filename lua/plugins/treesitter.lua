return {
	"nvim-treesitter/nvim-treesitter",
	version = "v0.9.3",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		-- Включаем подсветку синтаксиса
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},

		-- Умное выделение текста (индентация)
		indent = { enable = true },

		-- Список парсеров
		ensure_installed = {
			-- Frontend & Backend
			"javascript",
			"typescript",
			"tsx",
			"jsx",
			"vue",
			"html",
			"css",
			"scss",
			"sql",
			-- Other
			"lua",
			"vim",
			"vimdoc",
			"json",
			"yaml",
			"markdown",
			"markdown_inline",
			"bash",
			"dockerfile",
			"gitignore",

			"python",
			"c",
			"cpp",
		},
	},
}
