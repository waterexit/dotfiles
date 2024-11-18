local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd" , "pyright", "ruby_lsp"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

local vue_typescript_plugin = require("mason-registry").get_package("vue-language-server"):get_install_path() .. "/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"

lspconfig["tsserver"].setup({
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vue_typescript_plugin,
        languages = { "javascript", "typescript", "vue" },
      },
    },
  },
  filetypes = {
    "javascript",
    "typescript",
    "vue",
  },
})
