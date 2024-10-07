-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Enable the option to require a Prettier config file
-- If no prettier config file is found, the formatter will not be used
vim.g.lazyvim_prettier_needs_config = false
-- LazyVim picker to use.
-- Can be one of: telescope, fzf
-- Leave it to "auto" to automatically use the picker
-- enabled with `:LazyExtras`
vim.g.lazyvim_picker = "fzf"
--When this option is set, the screen will not be redrawn while executing
--macros, registers and other commands that have not been typed
vim.opt.lazyredraw = false

-- Display unprintable characters f12 - switches
vim.opt.list = true

-- Unprintable chars mapping
-- {tab = "••"|">~",eol = "↴"|"¶"|"$", nbsp = "␣"|"%", space = "_" }
vim.opt.listchars =
{ tab = [[→→]], trail = "•", extends = "»", precedes = "«" }

-- Enable folding
vim.opt.foldmethod = "expr"

vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- diable folding at startup
vim.opt.foldenable = false

-- set the number of screen lines above which a fold is displayed closed
vim.opt.foldminlines = 5
