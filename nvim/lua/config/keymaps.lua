local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--Split
map("n", "<leader>%", ":vsp <cr>")
map("n", '<leader>"', ":sp <cr>")

-- Previous buffer position
map("n", "<leader>''", ":b# <cr>")

-- Copy to clipboard
map("v", "<C-c>", ":'<'>w !pbcopy<cr>")
map("n", "<C-v>", ":r !pbpaste<cr>")

-- Yank file path to clipboard
map("n", "<leader>cfp", '<Cmd>let @+ = expand("%")<CR>', { desc = "[c]opy [f]ile [p]ath" })
-- Yank file name to clipboard with extention
map("n", "<leader>cfe", '<Cmd>let @+=expand("%:t")<CR>', { desc = "[c]opy [f]ilename with [e]xtention" })
-- Yank file name to clipboard without extention - usefull for dbt
map("n", "<leader>cfn", '<Cmd>let @+=expand("%:t:r")<CR>', { desc = "[c]opy [f]ile [n]ame" })

-- Stop search highlight
map("n", "<leader>-", ":noh <cr>")

-- Reload nvim config
map("n", "<leader>sv", ":source $MYVIMRC<cr>")

-- Telescope
map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
map("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")
map("n", "<leader>fs", '<cmd>lua require("telescope.builtin").git_status()<cr>')

-- Git Blame
map("n", "<Leader>bt", "<cmd>GitBlameToggle<cr>")
map("n", "<Leader>bo", "<cmd>GitBlameOpenCommitURL<cr>")

-- Trouble
map("n", "<Leader>xx", "<cmd>TroubleToggle<cr>")

-- LSP: Definition functions

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local bufmap = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- defaults:
		-- https://neovim.io/doc/user/news-0.11.html#_defaults

		bufmap("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
		bufmap("K", vim.lsp.buf.hover, "Hover Documentation")
		bufmap("gs", vim.lsp.buf.signature_help, "Signature Documentation")
		bufmap("gd", vim.lsp.buf.definition, "Goto definition")
		bufmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
		bufmap("<leader>la", vim.lsp.buf.code_action, "Code Action")
		bufmap("<leader>lr", vim.lsp.buf.rename, "Rename all references")
		bufmap("<leader>lf", vim.lsp.buf.format, "Format")
		bufmap("<leader>v", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", "Goto Definition in Vertical Split")

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
			bufmap("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})

-- QuickFix tab
map("n", "<leader>qfc", "<cmd>cclose<cr>")
map("n", "<leader>qfo", "<cmd>copen<cr>")
map("n", "<leader>cn", "<cmd>cnext<cr>zz")
map("n", "<leader>cp", "<cmd>cprev<cr>zz")
map("n", "<leader>k", "<cmd>lnext<cr>zz")
map("n", "<leader>j", "<cmd>lprev<cr>zz")

-- Undotree Toggle
map("n", "<leader>u", ":UndotreeToggle<cr>")

-- Move visual selection up and down
map("v", "J", ":m '>+1<cr>gv=gv")
map("v", "K", ":m '<-2<cr>gv=gv")

-- Improved J (cursor stays in place instead of end of line)
map("n", "J", "mzJ`z")

-- Improved Up and Down (cursor stays in the middle)
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Improved search (cursor stays in the middle
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Preserve yank after paste
map("x", "<leader>p", '"_dP')

-- Yank to clip
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')
map("n", "<leader>Y", '"+Y')

-- Awesome prime keymap to replace current selected word
map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Tabs
map("n", "<leader><Left>", "<Cmd>BufferPrevious<CR>")
map("n", "<leader><Right>", "<Cmd>BufferNext<CR>")
map("n", "<leader>w", "<Cmd>BufferClose<CR>")
map("n", "<leader>1", "<Cmd>BufferGoto 1<CR>")
map("n", "<leader>2", "<Cmd>BufferGoto 2<CR>")
map("n", "<leader>3", "<Cmd>BufferGoto 3<CR>")
map("n", "<leader>4", "<Cmd>BufferGoto 4<CR>")
map("n", "<leader>5", "<Cmd>BufferGoto 5<CR>")
map("n", "<leader>6", "<Cmd>BufferGoto 6<CR>")
map("n", "<leader>7", "<Cmd>BufferGoto 7<CR>")
map("n", "<leader>8", "<Cmd>BufferGoto 8<CR>")
map("n", "<leader>9", "<Cmd>BufferGoto 9<CR>")
map("n", "<leader>W", "<Cmd>BufferCloseAllButVisible<CR>")

-- Disable q recording
map("n", "q", "<Nop>")

-- NeoTree
map("n", "<Leader>n", "<cmd>Neotree reveal focus<cr>")
map("n", "\\", "<cmd>Neotree reveal toggle<cr>")

-- NeoGit
map("n", "<Leader>go", "<cmd>Neogit<cr>")

-- Disable q recording
map("n", "q", "<Nop>")

-- Resize panels
map("n", "<S-F9>", "<Cmd>5 winc <<CR>") -- decrease width
map("n", "<S-F10>", "<Cmd>5 winc +<CR>") -- increase width
map("n", "<S-F11>", "<Cmd>5 winc -<CR>") -- decrease height
map("n", "<S-F12>", "<Cmd>5 winc ><CR>") -- increase height
map("n", "<S-F8>", "<Cmd>winc =<CR>") -- reset all
