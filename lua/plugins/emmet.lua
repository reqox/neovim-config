return {
	"aca/emmet-ls",

	ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },

	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Новый API: vim.lsp.config вместо lspconfig
		vim.lsp.config("emmet_ls", {
			cmd = { "emmet-ls", "--stdio" },
			filetypes = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
			capabilities = capabilities,
			settings = {
				html = {
					options = {
						["bem.enabled"] = true,
					},
				},
			},
		})

		-- Включаем сервер
		vim.lsp.enable("emmet_ls")
	end,
}
