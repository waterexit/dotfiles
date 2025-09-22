local capabilities = require("ddc_source_lsp").make_client_capabilities()
--lua
vim.lsp.config('lua_ls', {
        settings = {
            Lua = {
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME
                    }
                }
            }
        },
        filetypes = { 'lua' },
        cmd = { '/home/water/dotfiles/lsp-installer/sumneko-lua-language-server' },
        capabilities = capabilities })

vim.lsp.enable('lua_ls')
--typescript
local is_node_dir = function()
    return require 'lspconfig'.util.root_pattern('package.json')(vim.fn.getcwd())
end
vim.lsp.config('ts_ls', {
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
                languages = { "typescript", "javascript", "vue" },
            },
        },
    },
    filetypes = {
        "javascript",
        "typescript",
        "javascriptreact",
        "vue",
    },
    capabilities = capabilities,
    on_attach = function(client)
        if not is_node_dir() then
            client.stop(true)
        else
            vim.notify("ts_ls is selected")
        end
    end
})
vim.lsp.enable('ts_ls')

vim.lsp.config('vue_ls' , { {filetype = {"vue"}} })
vim.lsp.enable('vue_ls')

vim.lsp.config('denols', {
    on_attach = function(client)
        if is_node_dir() then
            client.stop(true)
        else
            -- vim.notify("denols is selected")
        end
    end,
    capabilities = capabilities
})

--keymap
vim.keymap.set('n', "<Leader>gd", vim.lsp.buf.definition)
vim.keymap.set('n', "<Leader>fm", vim.lsp.buf.format)
vim.keymap.set('n', "<Leader>ca", vim.lsp.buf.code_action)
vim.keymap.set('n', "<Leader>ra", vim.lsp.buf.rename)
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, {})

