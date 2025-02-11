local data_dir = vim.fn.stdpath('data');
require("dap").adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "node",
        args = { data_dir .. "/debug_server/js-debug/src/dapDebugServer.js", "${port}" },
    }
}

require("dap").configurations.typescript = {
    {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        runtimeExecutable = "deno",
        runtimeArgs = {
            "run",
            "--inspect-wait",
            "--allow-all"
        },
        attachSimplePort = 9229,
        cwd = "${workspaceFolder}",
    },
    {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
    },
}

require("dapui").setup({})

require 'dap'.listeners.before['event_initialized']['custom'] = function(session, body)
    require 'dapui'.open()
end

require 'dap'.listeners.before['event_terminated']['custom'] = function(session, body)
    require 'dapui'.close()
end


vim.api.nvim_set_keymap('n', '<F5>', ':DapContinue<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F10>', ':DapStepOver<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F11>', ':DapStepInto<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F12>', ':DapStepOut<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':DapToggleBreakpoint<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>B', ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Breakpoint condition: "))<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>lp', ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>dr', ':lua require("dap").repl.open()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>dl', ':lua require("dap").run_last()<CR>', { silent = true })
