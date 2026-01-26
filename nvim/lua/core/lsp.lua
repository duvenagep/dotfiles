vim.lsp.enable({
    "bashls",
    "helm_ls",
    "jsonls",
    "lua_ls",
    "marksman",
    "pyright",
    "ruff",
    "rust_analyzer",
    "terraformls",
    "ts_ls",
    "vimls",
    "yamlls",
    "ty",
    "tombi",
})

vim.diagnostic.config({
    virtual_lines = false,
    virtual_text = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
})
