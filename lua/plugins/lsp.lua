return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "williamboman/mason.nvim", version = "v1.10.0" },
		{ "williamboman/mason-lspconfig.nvim", version = "v1.31.0" },
	},

	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "ts_ls", "lua_ls", "html", "cssls", "jsonls", "sqlls", "emmet_ls" },
			automatic_installation = true,
		})

		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()

		local function find_root_dir(fname)
			local util = require("lspconfig.util")
			local root = util.root_pattern("package.json", "tsconfig.json")(fname)
			if not root then
				root = util.root_pattern(".git")(fname)
			end
			return root
		end

		local on_attach = function(client, bufnr)
			local opts = { buffer = bufnr, silent = true }

			-- Навигация
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

			-- Документация и подсказки
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

			-- Рефакторинг
			vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

			-- Диагностика
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
		end

		local ts_servers = { "ts_ls", "emmet_ls" }
		for _, server in ipairs(ts_servers) do
			lspconfig[server].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				root_dir = find_root_dir,
			})
		end

		local other_servers = { "html", "cssls", "jsonls", "sqlls" }
		for _, server in ipairs(other_servers) do
			lspconfig[server].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					runtime = { version = "LuaJIT" },
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = { enable = false },
				},
			},
		})
	end,
}
