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
    },
})

vim.fn["ddu#custom#patch_local"]("help-ff", {
    sources = {
        { name = "help" },
    },
})

local keymap = vim.keymap.set
local ddu_do_action = vim.fn["ddu#ui#do_action"]

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

local function ddu_ff_filter_keymaps()
    keymap("i", "<CR>", function()
        vim.cmd.stopinsert()
        ddu_do_action("closeFilterWindow")
    end, { buffer = true })
    keymap("n", "<CR>", function()
        ddu_do_action("cloeFilterWindow")
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
    vim.fn["ddu#start"]({ name = "help-ff" })
end, {})
