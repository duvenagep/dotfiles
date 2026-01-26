return {
    "stevearc/conform.nvim",
    dependencies = {
        "kyazdani42/nvim-web-devicons",
    },
    config = function()
        require("conform").setup({
            formatters = {
                sqlfluff = {
                    command = "sqlfluff",
                    stdin = false,
                    cwd = require("conform.util").root_file({
                        ".sqlfluff.cfg",
                        ".sqlfluffignore",
                        ".git",
                    }),
                    args = {
                        "format",
                        "--dialect",
                        "clickhouse",
                        "--config",
                        "/Users/"
                        .. (os.getenv("USER") or os.getenv("USERNAME"))
                        .. "/Documents/Check/data/.sqlfluff_local.cfg",
                        "$FILENAME",
                    },
                },
            },
            formatters_by_ft = {
                python = { "isort" },
                lua = { "stylua" },
                json = { "jq" },
                jsonc = { "jq" },
                sql = { "sqlfluff" },
            },
            notify_on_error = true,
            format_on_save = {
                timeout_ms = 20000,
                lsp_fallback = true,
            },
        })
    end,
}
