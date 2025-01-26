local stdpath = vim.fn.stdpath("data")

-- アンドゥ履歴用ディレクトリを設定
local undodir = stdpath .. "/undo"
vim.o.undodir = undodir
vim.o.undofile = true
vim.fn.mkdir(undodir, "p")

-- NOTE: "filetype on" command should executed after dpp.vim change runtimepath.
-- if this line is at the firstline, filetype is empty.
-- probably, the reason "filetype on" searches tree-sitter setting from rutimepath.
vim.cmd ([[
	filetype indent plugin on
	syntax on
	set number
	set expandtab
	set shiftwidth=4
]])

-- 透明にする
vim.cmd([[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
  highlight NormalNC guibg=none
  highlight NormalSB guibg=none
]])
