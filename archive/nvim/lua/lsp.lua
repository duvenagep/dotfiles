-- Setup LSPs
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "terraformls",
        "pylsp",
        "marksman",
        "bashls",
        "yamlls",
        "vimls",
        "tsserver",
        "eslint",
        "tailwindcss",
        "sqlls",
        "ruff_lsp",
        "helm_ls",
    },
})

local cmp = require("cmp")
local lspconfig = require("lspconfig")
local format_on_save = require("format-on-save")
local formatters = require("format-on-save.formatters")
local ih = require("inlay-hints")

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

-- Rust
lspconfig.rust_analyzer.setup({
    -- on_attach = function(c, b)
    --     ih.on_attach(c, b)
    -- end,
    -- settings = {
    --     Rust = {
    --         hint = {
    --             enable = true,
    --         },
    --         only_current_line = true,
    --     },
    -- },
})

-- Terraform
lspconfig.terraformls.setup({})

-- Python
lspconfig.ruff_lsp.setup({
    init_options = {
        settings = {
            args = {
                "--extend-select", "E",
                "--extend-select", "F",
                "--extend-select", "W"
            },
        }
    }
})
lspconfig.pylsp.setup({
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = false
                },
                flake8 = {
                    enabled = false
                }
            }
        }
    }
}) -- Just for go to definition capabilities

-- Markdown
lspconfig.marksman.setup({})

-- Bash
lspconfig.bashls.setup({})

-- Yaml
lspconfig.yamlls.setup({})

-- Vim
lspconfig.vimls.setup({})

-- TypeScript
lspconfig.tsserver.setup({})

-- ESLint
lspconfig.eslint.setup({})

-- ESLint
lspconfig.tailwindcss.setup({})

-- SQL
lspconfig.sqlls.setup({})

-- Auto formatting
format_on_save.setup({
    formatter_by_ft = {
        html = formatters.lsp,
        css = formatters.lsp,
        javascript = formatters.lsp,
        json = formatters.lsp,
        lua = formatters.lsp,
        markdown = formatters.prettierd,
        python = {
            formatters.black,
            formatters.shell({
                cmd = { "ruff", "--fix", "-e", "-n", "-q", "--stdin-filename", "%", "-" }
            }),
        },
        rust = formatters.lsp,
        sh = formatters.shfmt,
        sql = formatters.shell({ cmd = { "sqlfluff", "format", "-" } }),
        terraform = formatters.lsp,
        typescript = formatters.prettierd,
        typescriptreact = formatters.prettierd,
        yaml = formatters.lsp,
    }
})

-- Autocompletion
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "vsnip" },
        { name = "buffer" },
        { name = "path" },
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }
})

-- Autocompletion: Commandline
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Autocompletion: Search
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'path' },
        { name = 'cmdline' }
    }
})
