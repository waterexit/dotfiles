-- NOTE: "filetype on" command should executed after dpp.vim change runtimepath.
-- if this line is at the firstline, filetype is empty.
-- probably, the reason "filetype on" searches tree-sitter setting from rutimepath.
vim.cmd[[
	filetype indent plugin on
	syntax on
	set number
	set expandtab
	set shiftwidth=4
]]
