-- keymap
vim.g.mapleader = " "
vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('', '<TAB>', '<CMD>tabn<CR>')
vim.keymap.set({ 'n', 'v', 'o', 'i' }, "<C-s>", "<cmd> :w <CR><ESC>")
