local first = require 'setting/dpp'.setup()
if not first then
    require 'setting/mapping'
    require 'setting/ddc'
    require 'setting/lsp'

    require 'setting/vim'

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
    vim.api.nvim_create_autocmd("User", { pattern = "Pomodoro:finish", callback = function() vim.cmd('Splash') end })

    require("telescope").setup {
        extensions = {
            file_browser = {
                theme = 'ivy',
                -- disables netrw and use telescope-file-browser in its place
                hijack_netrw = true,
                mappings = {
                    ["i"] = {
                        -- your custom insert mode mappings
                    },
                    ["n"] = {
                        -- your custom normal mode mappings
                    },
                },
            },
        },
    }
    -- To get telescope-file-browser loaded and working with telescope,
    -- you need to call load_extension, somewhere after setup function:
    require("telescope").load_extension "file_browser"

    require("notion").setup();

    vim.api.nvim_create_autocmd("User", {
        pattern = "SetEnv",
        callback = function()
            local value = os.getenv("key")
            vim.notify("a" .. value)
        end
    })
    require "denops-dotenv".setup()
else
    vim.notify("please restart")
end
