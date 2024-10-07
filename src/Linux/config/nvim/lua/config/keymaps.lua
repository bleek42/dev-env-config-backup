-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- folds
if vim.g.vscode then
    vim.keymap.set("n", "<C-b><C-s>", "<cmd>call VSCodeNotify('workbench.action.files.save')<cr>]")
    vim.keymap.set("n", "fmt", "<cmd>call VSCodeNotify('editor.action.formatDocument')<cr>")
    vim.keymap.set("n", "gi", "<cmd>call VSCodeNotify('editor.action.goToImplementation')<cr>")
    vim.keymap.set("n", "gn", "<cmd>call VSCodeNotify('editor.action.marker.next')<cr>")
    vim.keymap.set("n", "gp", "<cmd>call VSCodeNotify('editor.action.marker.prev')<cr>")
    vim.keymap.set("n", "gr", "<cmd>call VSCodeNotify('editor.action.rename')<cr>")
    vim.keymap.set("n", "gx", "<cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<cr>")

    vim.keymap.set("n", "<leader>k", "<cmd>HopChar1<cr>")
    vim.keymap.set("n", "<leader>l", "<cmd>HopLine<cr>")
    vim.keymap.set("n", "<leader>w", "<cmd>HopWord<cr>")
elseif vim.fn.executable("nnn") then
    vim.keymap.set("n", "<leader>oe", "<cmd>NnnExplorer<cr>", {
        desc = "Open Nnn Explorer",
    })

    vim.keymap.set("n", "<leader>op", "<cmd>NnnPicker<cr>", {
        desc = "Open Nnn Picker"
    })

elseif vim.fn.executable("ranger") then
    vim.keymap.set("n", "<leader>oe", "<cmd>RangerExplorer<cr>", {
        desc = "Open w/ Ranger file explorer ",
    })

    vim.keymap.set("n", "<leader>op", "<cmd>RangerPicker<cr>", {
        desc = "Open w/ Ranger file picker"
    })

elseif vim.fn.executable("lf") then
    vim.keymap.set("n", "<leader>oe", "<cmd>NnnExplorer<cr>", {
        desc = "Open w/ Lf file explorer"
    })

    vim.keymap.set("n", "<leader>op", "<cmd>LfPicker<cr>", {
        desc = "Open w/ Lf file picker"
    })

else
    vim.keymap.set("n", "<leader>fe", "<cmd>NeotreeExplorer<cr>", {
        desc = "Open w/ NeoTree file explorer"
    })

    vim.keymap.set("n", "<leader>fp", "<cmd>NeotreePicker<cr>", {
        desc = "Open  w/ NeoTree file picker"
    })
end

vim.keymap.set("n", "<Tab>", "<cmd>bn<cr>")
vim.keymap.set("n", "<S-Tab>", "<cmd>bp<cr>")

vim.keymap.set("n", "*", "*zz")

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- lsp
vim.keymap.set("n", "<leader><space>", "<cmd>CodeActionMenu<cr>", {
    desc = "Code Action Menu"
})

-- folds
vim.keymap.set("n", "<leader>z", "<cmd>normal! zMzv<cr>", {
    desc = "Fold all others"
})

-- harpoon
vim.keymap.set("n", "<leader>'", "<cmd>lua require('harpoon.mark').add_file()<cr>", {
    desc = "Add to Harpoon"
})
vim.keymap.set("n", "<leader>0", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", {
    desc = "Show Harpoon"
})
vim.keymap.set("n", "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", {
    desc = "Harpoon Buffer 1"
})
vim.keymap.set("n", "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", {
    desc = "Harpoon Buffer 2"
})
vim.keymap.set("n", "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", {
    desc = "Harpoon Buffer 3"
})
vim.keymap.set("n", "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", {
    desc = "Harpoon Buffer 4"
})
vim.keymap.set("n", "<leader>5", "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", {
    desc = "Harpoon Buffer 5"
})
vim.keymap.set("n", "<leader>6", "<cmd>lua require('harpoon.ui').nav_file(6)<cr>", {
    desc = "Harpoon Buffer 6"
})
vim.keymap.set("n", "<leader>7", "<cmd>lua require('harpoon.ui').nav_file(7)<cr>", {
    desc = "Harpoon Buffer 7"
})
vim.keymap.set("n", "<leader>8", "<cmd>lua require('harpoon.ui').nav_file(8)<cr>", {
    desc = "Harpoon Buffer 8"
})
vim.keymap.set("n", "<leader>9", "<cmd>lua require('harpoon.ui').nav_file(9)<cr>", {
    desc = "Harpoon Buffer 9"
})

-- buffer
vim.keymap.set("n", "<leader>bb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", {
    desc = "Telescope buffers"
})

-- clipboard
vim.keymap.set("v", "<leader>y", '"+y', {
    desc = "Yank to clipboard"
})

vim.keymap.set('n', '<D-s>', ':w<CR>')      -- Save
vim.keymap.set('v', '<D-c>', '"+y')         -- Copy
vim.keymap.set('n', '<D-v>', '"+P')         -- Paste normal mode
vim.keymap.set('v', '<D-v>', '"+P')         -- Paste visual mode
vim.keymap.set('c', '<D-v>', '<C-R>+')      -- Paste command mode
vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode


-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })
-- gen
vim.keymap.set("v", "<leader>]", ":Gen<CR>")
vim.keymap.set("n", "<leader>]", ":Gen<CR>")

vim.keymap.set("v", "<C-s>", ":sort<CR>")                         -- Sort highlighted text in visual mode in Control+S
vim.keymap.set("v", "<leader>rr", '"hy:%s/<C-r>h//g<left><left>') -- Replace all instances of highlighted words
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")                      -- Move current line down
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")                      -- Move current line up
vim.keymap.set("n", "<Tab>", "<cmd>bn<cr>")
vim.keymap.set("n", "<S-Tab>", "<cmd>bp<cr>")

vim.keymap.set("n", "*", "*zz")

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keymapper are automatically loaded on the VeryLazy event
-- Default keymapper that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymapper.lua
-- Add any additional keymapper here

-- local keymaps = {}

-- local function tabs()
--   keymapper.register(
--     "n",
--     {
--       ["<C-t><C-q>"] = [[<cmd>tabclose<cr>]],
--       ["<C-t><C-t>"] = [[<cmd>tabnew<cr>]],
--       ["<C-n>"] = [[<cmd>tabnext<cr>]],
--       ["<C-p>"] = [[<cmd>tabprevious<cr>]]
--     }
--   )
-- end

-- local function windows()
--   keymapper.register(
--     "n",
--     {
--       ["<C-w>x"] = [[<C-w>s]]
--       -- ["<leader>e"] = [[<cmd>nnn -e<cr>]]
--     }
--   )
-- end

-- local function navigations()
--   keymapper.register(
--     "n",
--     {
--       ["<C-a>"] = [[<cmd>TodoTrouble<cr>]],
--       ["<C-f><C-b>"] = [[<cmd>lua require'telescope.builtin'.buffers()<cr>]],
--       ["<C-f><C-d>"] = [[<cmd>lua require'telescope.builtin'.diagnostics()<cr>]],
--       ["<C-f><C-f>"] = [[<cmd>lua require'navigation.search'.git_or_local()<cr>]],
--       ["<C-f><C-g>"] = [[<cmd>lua require'telescope.builtin'.live_grep()<cr>]],
--       ["<C-f><C-h>"] = [[<cmd>lua require'telescope.builtin'.oldfiles()<cr>]],
--       ["<C-f><C-q>"] = [[<cmd>lua require'telescope.builtin'.quickfixhistory()<cr>]],
--       ["<C-f><C-p>"] = [[<cmd>Telescope persisted<cr>]],
--       ["<C-f><C-s>"] = [[<cmd>lua require'telescope.builtin'.lsp_document_symbols()<cr>]],
--       ["<C-f><C-a>"] = [[<cmd>lua require'telescope.builtin'.lsp_workspace_symbols()<cr>]],
--       ["<C-f><C-t>"] = [[<cmd>lua require'theme.theme_picker'.open_picker()<cr>]],
--       ["<C-g>"] = [[<cmd>nnn -e'<cr>]],
--       ["<C-q>"] = [[<cmd>Trouble quickfix<cr>]],
--       ["<C-x>"] = [[<cmd>Trouble workspace_diagnostics<cr>]]
--     }
--   )
-- end

-- local function buffer()
--   keymapper.register(
--     "n",
--     {
--       ["+"] = [[<C-a>]],
--       ["-"] = [[<C-x>]]
--     }
--   )
--   keymapper.register(
--     "x",
--     {
--       ["+"] = [[g<C-a>]],
--       ["-"] = [[g<C-x>]]
--     }
--   )
-- end

-- local function editor_motion()
--   keymapper.register(
--     "n",
--     {
--       ["<leader>w"] = [[<cmd>lua require("flash").treesitter()<cr>]],
--       ["<leader>t"] = [[<cmd>lua require("flash").treesitter_search()<cr>]]
--     }
--   )
-- end

-- local function editor_visual()
--   keymapper.register(
--     "v",
--     {
--       ["J"] = [[:m'>+1<CR>gv=gv]],
--       ["K"] = [[:m-2<CR>gv=gv]]
--     }
--   )
-- end

-- keymaps.editor_motion_textsubjects = {
--   init_selection = "<CR>",
--   scope_incremental = "<CR>"
-- }

-- keymaps.nnn = {
--     ["g?"] = "actions.show_help",
--     ["H"] = "actions.parent",
--     ["<CR>"] = "actions.select",
--     ["L"] = "actions.select_vsplit",
--     ["J"] = "actions.select_split",
--     ["<tab>"] = "actions.preview",
--     ["<C-c>"] = "actions.close",
--     ["<C-r>"] = "actions.refresh",
--     ["zh"] = "actions.toggle_hidden",
-- }

-- diagnostics
-- keymaps.diagnostics = {
-- ["close"] = "<C-c>",
-- ["cancel"] = "<C-k>",
-- ["refresh"] = "r",
-- ["jump"] = "<cr>",
-- ["hover"] = "K",
-- ["toggle_fold"] = "<space>",
-- ["previous"] = "<C-p>",
-- ["next"] = "<C-n>",
-- }

-- local function editor_dap()
--   keymapper.register(
--     "n",
--     {
--       ["<F5>"] = [[<cmd>lua require'dap'.continue()<cr>]],
--       ["<F10>"] = [[<cmd>lua require'dap'.step_over()<cr>]],
--       ["<F11>"] = [[<cmd>lua require'dap'.step_into()<cr>]],
--       ["<F12>"] = [[<cmd>lua require'dap'.step_out()<cr>]],
--       ["<leader>b"] = [[<cmd>lua require'dap'.toggle_breakpoint()<cr>]],
--       ["<leader>d"] = [[<cmd>lua require'dapui'.toggle()<cr>]],
--       ["<leader>c"] = [[<cmd>lua require'telescope'.extensions.dap.configurations{}<cr>]]
--     }
--   )
-- end

-- ---@diagnostic disable-next-line: unused-local
-- local function on_attach(client, bufnr)
--     vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

--     require("lsp_signature").on_attach({
--         bind = true,
--         handler_opts = {
--             border = "single",
--         },
--         hint_enabled = false,
--     })

--     keymapper.register_bufnr(bufnr, "n", keymaps.editor_on_text)
-- end
