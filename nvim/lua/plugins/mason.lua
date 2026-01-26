return {
    {
        "mason-org/mason.nvim",
        opts = {},
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "bashls",
                "helm_ls",
                "jsonls",
                "lua_ls",
                "marksman",
                "pyright",
                "ruff",
                "rust_analyzer",
                "terraformls",
                "vimls",
                "yamlls",
                "tombi",
            },
        },
    },
}
