local dpp_base = vim.fn.stdpath("config") .. "/.cache/dpp/"

-- same dpp using dir via git protocol
local runtime_root = dpp_base .. "repos/github.com/"
local runtime_plugins = { "vim-denops/denops.vim", "Shougo/dpp.vim", "Shougo/dpp-ext-installer", "Shougo/dpp-protocol-git", "Shougo/dpp-ext-toml", "Shougo/dpp-ext-lazy"}

for _, plugin in ipairs(runtime_plugins) do
	if not (vim.uv or vim.loop).fs_stat(runtime_root .. plugin) then
            vim.fn.system({
			"git",
			"clone",
			"https://github.com/" .. plugin .. ".git",
			runtime_root .. plugin
		})
	end
	vim.opt.rtp:prepend(runtime_root .. plugin)
end

local dpp = require("dpp")

M = {}

M.setup = function()
	local first = dpp.load_state(dpp_base)
	if first then
		local dpp_config = vim.fn.stdpath("config") .. "/dpp_config.ts"
		vim.api.nvim_create_autocmd("User", {
			pattern = "DenopsReady",
			callback = function()
				dpp.make_state(dpp_base, dpp_config)
			end
		})
	else
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = "*.lua,*.toml,*.ts",
			callback = function()
				dpp.check_files()
			end
		})
	end


	vim.api.nvim_create_autocmd("User", {
		pattern = "Dpp:makeStatePost",
		callback = function()
			dpp.load_state(dpp_base)
			vim.fn["dpp#async_ext_action"]('installer', 'install')
		end,
	})

	vim.api.nvim_create_user_command("DppUpdate", "call dpp#async_ext_action('installer', 'update')", {})
	return first;
end
return M
