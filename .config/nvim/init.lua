require 'setting/dpp'

require 'nvim-treesitter.configs'.setup {
	indent = { enable = true },
	highlight = { enable = true },
	auto_install = true,
	textobjects = { enable = true },
}

require 'setting/mapping'
require 'setting/ddc'
-- "filetype on" command execute at the end of init.lua because dpp.vim change runtimepath.
-- if this line is at the firstline, filetype is empty.
-- probably, the reason "filetype on" searches tree-sitter setting from rutimepath.
vim.cmd("filetype indent plugin on")
vim.cmd("syntax on")
vim.cmd("set number")

vim.keymap.set('n', "<Leader>gd", "<cmd>:lua vim.lsp.buf.definition()<CR>")
vim.keymap.set('n', "<Leader>fm", vim.lsp.buf.format)

local capabilities = require("ddc_source_lsp").make_client_capabilities()
--if false then
--	do return end
-- end
require 'lspconfig'.lua_ls.setup({ cmd={'/home/water/dotfiles/lsp-installer/sumneko-lua-language-server'}, capabilities= capabilities})
