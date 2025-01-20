-- ddc
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

vim.keymap.set({ 'n', 'v', 'i' }, '<C-n>', function() vim.fn["pum#map#select_relative"]('1') end)
vim.keymap.set({ 'n', 'v', 'i' }, '<C-p>', function() vim.fn["pum#map#select_relative"]('-1') end)
vim.keymap.set({ 'n', 'v', 'i' }, '<C-y>', vim.fn["pum#map#confirm"])
vim.keymap.set({ 'n', 'v', 'i' }, '<C-e>', vim.fn["pum#map#cancel"])
vim.keymap.set({ 'n', 'v', 'i' }, '<C-space>', vim.fn["ddc#map#manual_complete"])
