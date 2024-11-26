local first = require 'setting/dpp'.setup()
if not first then

    require 'setting/mapping'
    require 'setting/ddc'

    vim.keymap.set('n', "<Leader>gd", "<cmd>:lua vim.lsp.buf.definition()<CR>")
    vim.keymap.set('n', "<Leader>fm", vim.lsp.buf.format)
    vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, {})

    local capabilities = require("ddc_source_lsp").make_client_capabilities()
    require 'lspconfig'.lua_ls.setup({ cmd = { '/home/water/dotfiles/lsp-installer/sumneko-lua-language-server' }, capabilities = capabilities })
    require 'lspconfig'.denols.setup({ capabilities = capabilities })

    require 'setting/vim'

    require 'nvim-treesitter.configs'.setup {
        indent = { enable = true },
        highlight = { enable = true },
        auto_install = true,
        textobjects = { enable = true },
    }

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'Telescope help tags' })
else
    vim.notify("please restart")
end
