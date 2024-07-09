return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
		opts = function(_, opts)
			-- none-ls is actually null-ls under-the-hood
			local nls = require("null-ls").builtins

			opts.sources = {
				---- Python
				-- nls.formatting.black.with({
				--     exe = "black",
				--     stdin = true,
				--     args = { "-q", "-" },
				-- }),
				-- nls.formatting.ruff.with({
				--     exe = "ruff",
				--     stdin = true,
				--     args = {
				--         -- attempt to automatically fix lint violations
				--         "--fix",
				--         -- exit with 0
				--         "-e",
				--         -- no-cache
				--         "-n",
				--         -- quiet
				--         "-q",
				--         "--stdin-filename",
				--         "%",
				--         -- push output into stdout
				--         "-",
				--     },
				-- }),

				--SQL
				nls.diagnostics.sqlfluff.with({
					extra_args = { "--dialect", "redshift" },
				}),
				-- nls.formatting.sqlfluff.with({
				--     exe = "sqlfluff",
				--     stdin = true,
				--     args = {
				--         "format",
				--         "-",
				--     },
				-- }),
				-- Generics
				-- nls.formatting.stylua,
			}
		end,
	},
}
