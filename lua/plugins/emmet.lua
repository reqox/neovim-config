return {
	-- ШАГ 1: Простой и рабочий Emmet
	"aca/emmet-ls",

	-- ШАГ 2: Загружать для нужных файлов
	ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },

	-- ШАГ 3: Интеграция с LSP
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		lspconfig.emmet_ls.setup({
			capabilities = capabilities,
			filetypes = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
			init_options = {
				html = {
					options = {
						-- Для React используем className вместо class
						["bem.enabled"] = true,
					},
				},
			},
		})
	end,
}
