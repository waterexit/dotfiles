local first = require 'setting/dpp'.setup()
if not first then
    require 'setting/mapping'
    require 'setting/ddc'
    require 'setting/ddu'
    require 'setting/lsp'

    require 'setting/vim'
    require 'setting/debugger'

    require 'nvim-treesitter.configs'.setup {
        indent = { enable = true },
        highlight = { enable = true },
        auto_install = true,
        textobjects = { enable = true },
    }


    -- local dpp_base = vim.fn.stdpath("config") .. "/.cache/dpp/"
    -- local runtime_root = dpp_base .. "repos/github.com/"
    -- vim.opt.rtp:prepend(runtime_root .. "vim-denops/denops.vim")
    require "expand-splash"
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    -- custom action for help_tags
    local open_help_in_tab = function(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        if entry then
            actions.close(prompt_bufnr)
            vim.cmd(string.format("tab help %s", entry.value))
        end
    end
    require("telescope").setup {
        defaults = {
        },
        pickers = {
            help_tags = {
                mappings = {
                    i = {
                        ["<CR>"] = open_help_in_tab,
                    },
                    n = {
                        ["<CR>"] = open_help_in_tab,
                    },
                },
            },
        },
        extensions = {
            file_browser = {
                hidden = true,
                theme = 'ivy',
                -- disables netrw and use telescope-file-browser in its place
                hijack_netrw = true,
            },
        },
    }
    -- To get telescope-file-browser loaded and working with telescope,
    -- you need to call load_extension, somewhere after setup function:
    require("telescope").load_extension "file_browser"

    require "denops-dotenv".setup()
    vim.api.nvim_create_autocmd("User", {
        pattern = "SetEnv",
        callback = function()
            require("notion").setup();
        end
    })
else
    vim.notify("please restart")
end
