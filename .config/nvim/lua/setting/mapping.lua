-- keymap
vim.g.mapleader = " "
vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('', '<TAB>', '<CMD>tabn<CR>')
vim.keymap.set({ 'n', 'v', 'o', 'i' }, "<C-s>", "<cmd> :w <CR><ESC>")


vim.keymap.set('n', "<Leader>gd", "<cmd>:lua vim.lsp.buf.definition()<CR>")
vim.keymap.set('n', "<Leader>fm", vim.lsp.buf.format)
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, {})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'Telescope lsp reference' })
vim.cmd("imap <C-j> <Plug>(skkeleton-enable)")
