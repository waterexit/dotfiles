vim.fn["ddu#custom#patch_global"]({
    ui = "ff",
    uiParams = {
        ff = {
            startAutoAction = true,
            autoAction = {
                delay = 0,
                name = "preview",
            },
            split = "vertical",
            splitDirection = "topleft",
            startFilter = true,
            winWidth = "&columns / 2 - 2",
            previewFloating = true,
            previewHeight = "&lines - 8",
            previewWidth = "&columns / 2 - 2",
            previewRow = 1,
            previewCol = "&columns / 2 + 1",
        },
    },
    sourceOptions = {
        _ = {
            matchers = { "matcher_substring" },
        },
        help = {
            defaultAction = "open",
        },
        rss = {
            defaultAction = "open",
        },
    },
    kindOptions = {
        page = {
            defaultAction = "open",
        },
    }
})

vim.fn["ddu#custom#patch_local"]("rss-flux", {
    ui = "flux",
    sources = {
        { name = "rss" },
    },
})

vim.fn["ddu#custom#patch_local"]("source-test", {
    sources = {
        { name = "rss" },
    },
})

local keymap = vim.keymap.set
local ddu_do_action = vim.fn["ddu#ui#do_action"]

-- local function ddu_compact_keymaps()
--     keymap("n", "<CR>", function()
--         ddu_do_action("itemAction")
--     end, { buffer = true })
--     keymap("n", "i", function()
--         ddu_do_action("openFilterWindow")
--     end, { buffer = true })
-- end
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "ddu-compact",
--     callback = ddu_compact_keymaps,
-- })

vim.api.nvim_set_keymap("n", "<C-e>q", ':call ddu#ui#do_action("quit", {}, "rss-flux") <CR>', {})
vim.api.nvim_set_keymap("n", "<C-e>n", ':call ddu#ui#do_action("next", {}, "rss-flux") <CR>', {})
vim.api.nvim_set_keymap("n", "<C-e>p", ':call ddu#ui#do_action("prev", {}, "rss-flux") <CR>', {})
vim.api.nvim_set_keymap("n", "<C-e><CR>", ':call ddu#ui#do_action("itemAction", {}, "rss-flux") <CR>', {})

local function ddu_ff_filter_keymaps()
    keymap("i", "<CR>", function()
        vim.cmd.stopinsert()
        ddu_do_action("closeFilterWindow")
    end, { buffer = true })
    keymap("n", "<CR>", function()
        ddu_do_action("cloeFilterWindow")
    end, { buffer = true })
end

local function ddu_ff_keymaps()
    keymap("n", "<CR>", function()
        ddu_do_action("itemAction")
    end, { buffer = true })
    keymap("n", "i", function()
        ddu_do_action("openFilterWindow")
    end, { buffer = true })
    keymap("n", "q", function()
        ddu_do_action("quit")
    end, { buffer = true })
end
vim.api.nvim_create_autocmd("FileType", {
    pattern = "ddu-ff",
    callback = ddu_ff_keymaps,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "ddu-ff-filter",
    callback = ddu_ff_filter_keymaps,
})

vim.api.nvim_create_user_command("Help", function()
    vim.fn["denops#server#restart"]()
    vim.fn["ddu#start"]({ name = "rss-flux" })
end, {})
vim.api.nvim_create_user_command("Test", function()
    vim.fn["denops#server#restart"]()
    vim.fn["ddu#start"]({ name = "source-test" })
end, {})
