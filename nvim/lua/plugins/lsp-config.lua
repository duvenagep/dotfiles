local function disableFmtProvider(client)
	client.server_capabilities.documentFormattingProvider = false
end

return {
	-- Installs all lsps
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	-- Bridges gap between mason and nvim--lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ruff_lsp",
					"rust_analyzer",
					"jedi_language_server",
					"sqlls",
					"terraformls",
					"marksman",
					"bashls",
					"yamlls",
					"helm_ls",
					"slint_lsp",
				},
			})
		end,
	},
	-- Setup lsp keymaps
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			-- Lua
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = {
								"vim",
							},
						},
					},
				},
			})

			-- Python
			lspconfig.ruff_lsp.setup({
				capabilities,
				init_options = {
					settings = {
						args = {
							"--extend-select",
							"E",
							"--extend-select",
							"F",
							"--extend-select",
							"W",
						},
					},
				},
			})

			lspconfig.jedi_language_server.setup({}) -- used only for Go To Definition capabilities

			-- Rust
			lspconfig.rust_analyzer.setup({
				capabilities,
				assist = {
					importEnforceGranularity = true,
					importPrefix = "crate",
				},
				cargo = {
					allFeatures = true,
				},
				inlayHints = { locationLinks = false },
				diagnostics = {
					enable = true,
					experimental = {
						enable = true,
					},
				},
			})

			-- SQL
			lspconfig.sqlls.setup({
				capabilities,
			})

			-- Terraform
			lspconfig.terraformls.setup({})

			-- Markdown
			lspconfig.marksman.setup({})

			-- Bash
			lspconfig.bashls.setup({})

			-- Yaml
			lspconfig.yamlls.setup({})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					local opt = { buffer = ev.buf }

					vim.keymap.set("n", "gr", vim.lsp.buf.references, opt)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opt)
					vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opt)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opt)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opt)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opt)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opt)

					vim.keymap.set("n", "<leader>fd", function()
						require("conform").format({ bufnr = ev.buf, lsp_fallback = true, async = true })
						-- vim.lsp.buf.format({ async = true })
					end, opt)
				end,
			})

			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					require("conform").format({ bufnr = args.buf })
					-- vim.lsp.buf.format({ async = false })
				end,
			})

			-- Slint
			vim.cmd([[ autocmd BufRead,BufNewFile *.slint set filetype=slint ]])
			lspconfig.slint_lsp.setup({})
		end,
	},
}
