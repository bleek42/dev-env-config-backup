if vim.loader and vim.fn.has("nvim-0.9.1") == 1 then
  vim.loader.enable()
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system(
    {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath
    }
  )
end

vim.opt.rtp:prepend(lazypath)

local opts = {}

if vim.loop.os_uname().version:match("Windows") then
  opts.concurrency = 1
end

if vim.g.vscode then
  local vscode = require("vscode")
  vscode.configure()

  opts.root = vim.fn.stdpath("data") .. "/lazy-vscode"
  opts.lockfile = vim.fn.stdpath("config") .. "/lazy-vscode-lock.json"

  require("lazy").setup(vscode.packages(), opts)

else
  local neovim = require("neovim")

  neovim.setup()
  require("lazy").setup("plugins", options)

  neovim.activate_theme()
  neovim.configure_mappings()
  neovim.configure_lsp()

end
