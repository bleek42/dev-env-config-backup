-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- FIX: currently not working: vim.opt.formatoptions:remove { "c", "r", "o" }
-- https://github.com/neovim/neovim/blob/a49923a318520a3b5c2f210f22a8d450165e89b5/runtime/ftplugin/lua.vim#L20
-- vim.api.nvim_create_autocmd(
--   "FileType",
--   {
--     command = "set formatoptions-=cro"
--   }
-- )



-- vim.cmd([[set fillchars=eob:\ ,]])
-- vim.cmd([[set shortmess+=c]])
-- vim.cmd([[set undofile]])

