return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"lua",
				"rust",
				"toml",
				"yaml",
				"python",
				"terraform",
				"dockerfile",
				"sql",
			},
			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
			rainbow = {
				enable = true,
			},
		})
	end,
}
