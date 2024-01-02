return require('packer').startup(function(use)
    -- Packer
    use 'wbthomason/packer.nvim'

    -- catppuccin theme
    use { "catppuccin/nvim", as = "catppuccin" }

    -- LSP
    use {
        'williamboman/mason.nvim',
        requires = {
            'williamboman/mason-lspconfig.nvim',
            'neovim/nvim-lspconfig',
        },
    }


    -- Autocompletion framework
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
        }
    }

    -- Syntax Highlighting
    use 'nvim-treesitter/nvim-treesitter'

    -- Debug Adapter
    use 'puremourning/vimspector'

    -- Finding files
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'BurntSushi/ripgrep',
            'junegunn/fzf',
        }
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }

    -- Diagnostics
    use {
        "folke/trouble.nvim",
        requires = {
            "kyazdani42/nvim-web-devicons",
        },
    }

    -- Seamless navigation between vim and tmux
    use 'christoomey/vim-tmux-navigator'

    -- Helm files
    use 'towolf/vim-helm'

    -- Code block commenting
    use 'tpope/vim-commentary'

    -- Git Blame
    use 'f-person/git-blame.nvim'

    -- Undotree
    use 'mbbill/undotree'

    -- Tabs
    use 'romgrk/barbar.nvim'

    -- Colorful window separation
    use 'nvim-zh/colorful-winsep.nvim'

    -- lualine
    use 'nvim-lualine/lualine.nvim'

    -- Auto Pairs
    -- use 'jiangmiao/auto-pairs'
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    -- LuaSnip Autocompletions
    use({
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v<CurrentMajor>.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        run = "make install_jsregexp"
    })

    -- File Tree
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        }
    }

    -- NeoGit
    use {
        'NeogitOrg/neogit',
        requires = {
            'nvim-lua/plenary.nvim',
        }
    }

    -- Formatter
    use 'elentok/format-on-save.nvim'

    -- Which Key
    use 'folke/which-key.nvim'

    -- Inlay Hints
    use('simrat39/inlay-hints.nvim')
end)
