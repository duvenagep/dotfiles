return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"dockerfile",
				"lua",
				"python",
				"rust",
				"sql",
				"terraform",
				"toml",
				"yaml",
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			fold = {
				enable = true,
			},
		})
	end,
}
