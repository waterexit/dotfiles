local runtime_root = vim.fn.stdpath("config") .. "/runtime/"
local runtime_plugins = { "vim-denops/denops.vim", "Shougo/dpp.vim", "Shougo/dpp-ext-installer", "Shougo/dpp-protocol-git", "Shougo/dpp-ext-toml", "Shougo/dpp-ext-lazy", "Shougo/dpp-ext-local.git" }
for _, plugin in ipairs(runtime_plugins) do
	if not (vim.uv or vim.loop).fs_stat(runtime_root .. plugin) then
		vim.fn.system({
			"git",
			"clone",
			"https://github.com/" .. plugin .. ".git",
			runtime_root .. plugin
		})
	end
	vim.opt.rtp:prepend(runtime_root .. plugin)
end

local dpp_base = vim.fn.stdpath("config") .. "/runtime/plugin_sources"
local dpp_config = vim.fn.stdpath("config") .. "/dpp_config.ts"

vim.opt.runtimepath:append(runtime_root .. "Shougo/dpp.vim")
local dpp = require("dpp")

local denops_src = runtime_root .. "vim-denops/denops.vim"
if dpp.load_state(dpp_base) then
	vim.opt.rtp:prepend(denops_src)
	vim.api.nvim_create_autocmd("User", {
		pattern = "DenopsReady",
		callback = function()
			dpp.make_state(dpp_base, dpp_config)
		end
	})
end

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.lua,*.toml,*.ts",
	callback = function()
		dpp.check_files()
	end
})

vim.api.nvim_create_autocmd("User", {
	pattern = "Dpp:makeStatePost",
	callback = function()
		dpp.load_state(dpp_base)
		vim.fn["dpp#async_ext_action"]('installer', 'install')
		vim.notify("dpp make_state() is done")
	end,
})

vim.api.nvim_create_user_command("DppInstall", "call dpp#async_ext_action('installer', 'install')", {})

require 'nvim-treesitter.configs'.setup {
	indent = { enable = true },
	highlight = { enable = true },
	auto_install = true,
	textobjects = { enable = true },
}
-- keymap
vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('', '<TAB>', '<CMD>tabn<CR>')
vim.keymap.set({'n','v','o','i'}, "<C-s>", "<cmd> :w <CR><ESC>")

-- "filetype on" command execute at the end of init.lua because dpp.vim change runtimepath.
-- if this line is at the firstline, filetype is empty.
-- probably, the reason "filetype on" searches tree-sitter setting from rutimepath.
vim.cmd("filetype indent plugin on")
vim.cmd("syntax on")
vim.cmd("set number")


vim.g.mapleader = " "
vim.keymap.set('n', "<Leader>gd", "<cmd>:lua vim.lsp.buf.definition()<CR>")
vim.keymap.set('n', "<Leader>fm", vim.lsp.buf.format)

vim.cmd([[ 
call ddc#custom#patch_global('ui', 'pum')

call ddc#custom#patch_global('sources', ['lsp'])

call ddc#custom#patch_global('sourceOptions', #{
      \ _: #{
      \   matchers: ['matcher_head'],
      \   sorters: ['sorter_rank']
      \ },
      \ lsp: #{
      \     mark: 'lsp',
      \     forceCompletionPattern: '\.\w*|:\w*|->\w*'
      \ },
      \ })

call ddc#custom#patch_global('sourceParams', #{
      \   lsp: #{
      \     snippetEngine: denops#callback#register({
      \           body -> vsnip#anonymous(body)}),
      \     enableResolveItem: v:true,
      \     enableAdditionalTextEdit: v:true,
      \   }
      \ })
call ddc#enable()
]])

vim.keymap.set({'n','v','i'}, '<C-n>', function() vim.fn["pum#map#select_relative"]('+1') end)
vim.keymap.set({'n','v','i'}, '<C-p>', function() vim.fn["pum#map#select_relative"]('-1') end)
vim.keymap.set({'n','v','i'}, '<C-y>', vim.fn["pum#map#confirm"])
vim.keymap.set({'n','v','i'}, '<C-e>', vim.fn["pum#map#cancel"])
vim.keymap.set({'n','v','i'}, '<C-l>', vim.fn["ddc#map#manual_complete"])

local capabilities = require("ddc_source_lsp").make_client_capabilities()
require 'lspconfig'.lua_ls.setup({ cmd={'/home/water/dotfiles/lsp-installer/sumneko-lua-language-server'}, capabilities= capabilities})
