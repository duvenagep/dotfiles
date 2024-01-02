return {
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
            -- animation = true,
            -- insert_at_start = true,
            -- …etc.
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released

-- -- Tabs config
-- local filetreename = 'neo-tree'
-- local function get_filetree_window()
--     for _, windowId in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
--         local buffer = vim.api.nvim_win_get_buf(windowId)
--         if vim.api.nvim_buf_get_option(buffer, 'ft') == filetreename then
--             return windowId
--         end
--     end
--     return nil
-- end

-- local function get_filetree_width()
--     local windowId = get_filetree_window()
--     if windowId == nil then return end
--     return vim.fn.winwidth(windowId)
-- end

-- vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinScrolled', 'BufWinLeave', 'BufWipeout' }, {
--     callback = function()
--         local width = get_filetree_width()

--         require('barbar.api').set_offset(width or 0)
--     end
-- })
    },

}
