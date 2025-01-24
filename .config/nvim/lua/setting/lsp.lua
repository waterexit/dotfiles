local capabilities = require("ddc_source_lsp").make_client_capabilities()
--lua
require 'lspconfig'.
    lua_ls.setup({
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

--typescript
local is_node_dir = function()
    return require 'lspconfig'.util.root_pattern('package.json')(vim.fn.getcwd())
end
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
    filetypes = {
        "javascript",
        "typescript",
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
}
require 'lspconfig'.volar.setup { { filetypes = { "vue" } } }

require 'lspconfig'.denols.setup {
    on_attach = function(client)
        if is_node_dir() then
            client.stop(true)
        else
            -- vim.notify("denols is selected")
        end
    end,
    capabilities = capabilities
}
