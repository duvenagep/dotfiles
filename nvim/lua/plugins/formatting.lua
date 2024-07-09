return {
	"stevearc/conform.nvim",
	opts = function(_, opts)
		opts.formatters = {
			formatters = {
				sqlfluff = {
					command = "sqlfluff",
					args = { "format", "--dialect", "redshift", "-" },
					stdin = true,
				},
			},
		}

		opts.formatters_by_ft = {
			lua = { "stylua" },
			sql = { "sqlfluff" },
			python = { "isort", "ruff_format" },
		}
	end,
}
