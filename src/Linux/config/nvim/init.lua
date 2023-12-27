if vim.loader and vim.fn.has "nvim-0.9.1" == 1 then
	vim.loader.enable()
end

if vim.g.vscode then
	local vscode = require("vscode")
	vscode.configure()

	local options = {
		root = vim.fn.stdpath("data") .. "/lazy-vscode",
		lockfile = vim.fn.stdpath("config") .. "/lazy-vscode-lock.json"
	}
	if vim.loop.os_uname().version:match("Windows") then
		options.concurrency = 1
	end

	require("astronvim.lazy").setup(vscode.packages(), options)
end

require("astronvim.utils").conditional_func(astronvim.user_opts("polish", nil, false), true)
