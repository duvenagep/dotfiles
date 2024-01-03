return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "BurntSushi/ripgrep",
            "junegunn/fzf",
        },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<Leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<Leader>pg", builtin.live_grep, {})
        end,
    },

    {
        "nvim-telescope/telescope-ui-select.nvim",
        -- "nvim-telescope/telescope-fzf-native.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                    -- ["fzf"] = {
                    --     fuzzy = true,
                    --     override_generic_sorter = true,
                    --     override_file_sorter = true,
                    --     case_mode = "smart_case",
                    -- },
                },
            })

            require("telescope").load_extension("ui-select")
            -- require("telescope").load_extension("fzf")
        end,
    },

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    },
}
