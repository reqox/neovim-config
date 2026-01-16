return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},

	config = function()
		require("mason").setup()

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

			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
		end

		-- Кастомизация конфигов через vim.lsp.config()
		vim.lsp.config("ts_ls", {
			capabilities = capabilities,
			on_attach = on_attach,
			root_dir = find_root_dir,
		})

		vim.lsp.config("emmet_ls", {
			capabilities = capabilities,
			on_attach = on_attach,
			root_dir = find_root_dir,
		})

		vim.lsp.config("lua_ls", {
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

		-- Для остальных серверов просто capabilities и on_attach
		for _, server in ipairs({ "html", "cssls", "jsonls", "sqlls" }) do
			vim.lsp.config(server, {
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end

		-- Mason-lspconfig с handlers для автозапуска
		require("mason-lspconfig").setup({
			ensure_installed = { "ts_ls", "lua_ls", "html", "cssls", "jsonls", "sqlls", "emmet_ls" },
			automatic_installation = true,
			handlers = {
				-- Дефолтный handler для всех серверов
				function(server_name)
					vim.lsp.enable(server_name)
				end,
			},
		})
	end,
}
