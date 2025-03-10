return {
	-- Installs all lsps
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			{ "j-hui/fidget.nvim", opts = {} },
			{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },

			-- Autoformatting
			"stevearc/conform.nvim",

			-- Schema information
			"b0o/SchemaStore.nvim",
		},
		config = function()
			local capabilities = nil
			if pcall(require, "cmp_nvim_lsp") then
				capabilities = require("cmp_nvim_lsp").default_capabilities()
			end

			local lspconfig = require("lspconfig")

			local servers = {
				bashls = true,
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
					server_capabilities = {
						semanticTokensProvider = vim.NIL,
					},
				},

				rust_analyzer = true,
				terraformls = true,
				helm_ls = true,

				pyright = {
					settings = {
						pyright = {
							disableOrganizeImports = true,
						},
						python = {
							analysis = {
								ignore = { "*" },
							},
						},
					},
				},
				ruff = {
					init_options = {
						settings = {
							args = {
								"--extend-select",
								"E",
								"--extend-select",
								"F",
								"--extend-select",
								"W",
								"--extend-select",
								"I",
								"--extend-select",
								"F401", -- unused imports
							},
						},
					},
				},
				jsonls = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},
			}

			local servers_to_install = vim.tbl_filter(function(key)
				local t = servers[key]
				if type(t) == "table" then
					return not t.manual_install
				else
					return t
				end
			end, vim.tbl_keys(servers))

			require("mason").setup()
			local ensure_installed = {
				"stylua",
				"isort",
			}

			vim.list_extend(ensure_installed, servers_to_install)
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			for name, config in pairs(servers) do
				if config == true then
					config = {}
				end
				config = vim.tbl_deep_extend("force", {}, {
					capabilities = capabilities,
				}, config)

				lspconfig[name].setup(config)
			end

			local disable_semantic_tokens = {
				lua = true,
			}

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(args)
					local bufnr = args.buf
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

					local settings = servers[client.name]
					if type(settings) ~= "table" then
						settings = {}
					end

					-- if client.server_capabilities.documentSymbolProvider then
					-- 	navic.attach(client, bufnr)
					-- end

					local builtin = require("telescope.builtin")
					local opt = { buffer = 0 }

					vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

					vim.keymap.set("n", "gd", builtin.lsp_definitions, opt)
					vim.keymap.set("n", "gr", builtin.lsp_references, opt)

					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opt)
					vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opt)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opt)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opt)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opt)

					local filetype = vim.bo[bufnr].filetype
					if disable_semantic_tokens[filetype] then
						client.server_capabilities.semanticTokensProvider = nil
					end

					-- Override server capabilities
					if settings.server_capabilities then
						for k, v in pairs(settings.server_capabilities) do
							if v == vim.NIL then
								---@diagnostic disable-next-line: cast-local-type
								v = nil
							end

							client.server_capabilities[k] = v
						end
					end
				end,
			})

			-- Autoformatting Setup with Conform
			require("conform").setup({
				formatters = {
					sqlfluff = {
						command = "sqlfluff",
						stdin = true,
						args = {
							"format",
							"--dialect",
							"redshift",
							"--config",
							"/Users/"
								.. (os.getenv("USER") or os.getenv("USERNAME"))
								.. "/Documents/Check/data/.sqlfluff",
							"-",
						},
					},
					-- sqruff = {
					-- 	command = "sqruff",
					-- 	stdin = true,
					-- 	args = {
					-- 		"fix",
					-- 		"--force",
					-- 		"--config",
					-- 		"/Users/"
					-- 			.. (os.getenv("USER") or os.getenv("USERNAME"))
					-- 			.. "/Documents/Check/data/.sqlfluff",
					-- 		"-",
					-- 	},
					-- },
				},
				formatters_by_ft = {
					lua = { "stylua" },
					sql = { "sqlfluff" },
					-- sql = { "sqruff" },
					python = { "ruff_format", "ruff_organize_imports", "ruff_fix" },
				},
			})

			-- Format on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function(args)
					require("conform").format({
						bufnr = args.buf,
						lsp_fallback = true,
						quiet = true,
					})
				end,
			})

			-- Floating LSP help lines
			require("lsp_lines").setup()
			vim.diagnostic.config({ virtual_text = false, virtual_lines = true })

			-- Slint
			vim.cmd([[ autocmd BufRead,BufNewFile *.slint set filetype=slint ]])
			lspconfig.slint_lsp.setup({})
		end,
	},
}
