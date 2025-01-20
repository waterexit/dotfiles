local first = require 'setting/dpp'.setup()
if not first then

    require 'setting/mapping'
    require 'setting/ddc'

    local capabilities = require("ddc_source_lsp").make_client_capabilities()
    require 'lspconfig'.lua_ls.setup({ filetypes = { 'lua' }, cmd = { '/home/water/dotfiles/lsp-installer/sumneko-lua-language-server' }, capabilities = capabilities })
    --require 'lspconfig'.denols.setup({  capabilities = capabilities })
    require 'lspconfig'.ts_ls.setup {
        init_options = {
            plugins = {
                {
                    name = "@vue/typescript-plugin",
                    location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
                    languages = { "typescript", "javascript", "vue" },
                },
            },
        },
        filetypes = { "javascript",
            "typescript",
            "vue",
        },
        capabilities = capabilities
    }
    require 'lspconfig'.volar.setup { { filetypes = { "vue" } } }
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
