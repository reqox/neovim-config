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
		require("mason-lspconfig").setup({
			ensure_installed = { "ts_ls", "lua_ls", "html", "cssls", "jsonls", "sqlls", "emmet_ls" },
		})

		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()

		local function get_root_dir(fname)
			return vim.fs.root(fname, { "package.json", "tsconfig.json" }) or vim.fs.root(fname, { ".git" })
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

		local servers = { "ts_ls", "lua_ls", "html", "cssls", "jsonls", "sqlls" }
		for _, server in ipairs(servers) do
			local config = {
				capabilities = capabilities,
				on_attach = on_attach,
				root_dir = get_root_dir,
			}

			if server == "lua_ls" then
				config.settings = { Lua = { diagnostics = { globals = { "vim" } } } }
			end

			lspconfig[server].setup(config)
		end
	end,
}
