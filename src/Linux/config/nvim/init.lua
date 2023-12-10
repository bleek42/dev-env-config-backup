if vim.loader and vim.fn.has "nvim-0.9.1" == 1 then vim.loader.enable() end

for _, source in ipairs {
  "astronvim.bootstrap",
  "astronvim.options",
  "astronvim.lazy",
  "astronvim.autocmds",
  "astronvim.mappings",
} do
  local status_ok, fault = pcall(require, source)
  if not status_ok then vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault) end
end

if astronvim.default_colorscheme and not vim.g.vscode then
  if not pcall(vim.cmd.colorscheme, astronvim.default_colorscheme) then
    require("astronvim.utils").notify(
      ("Error setting up colorscheme: `%s`"):format(astronvim.default_colorscheme),
      vim.log.levels.ERROR
    )
  end
end

if vim.g.vscode then
	    local vscode = require("vscode")
    vscode.configure()

    local options = {
        root = vim.fn.stdpath("data") .. "/lazy-vscode",
        lockfile = vim.fn.stdpath("config") .. "/lazy-vscode-lock.json",
    }
    if vim.loop.os_uname().version:match("Windows") then
        options.concurrency = 1
    end

	require("astronvim.lazy").setup(vscode.packages(), options)
end

require("astronvim.utils").conditional_func(astronvim.user_opts("polish", nil, false), true)
