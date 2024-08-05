return {

    {
        "nvim-neo-tree/neo-tree.nvim",
        enabled = function()
            if vim.fn.executable("nnn") or not vim.fn.executable("ranger") or not vim.fn.executable("lf") then
                return false
            end

            return true
        end,
    },

    {
        "kelly-lin/ranger.nvim",
        cmd = {
            "Ranger"
        },
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        enabled = function()
            if vim.fn.executable('ranger') then
                return true
            end

            return false
        end,


        config = function()
            local ranger_open = require("ranger-nvim").OPEN_MODE
            require("ranger-nvim").setup({
                replace_netrw = true,
                enable_cmds = true,

                keybinds = {
                    ["ov"] = ranger_open.vsplit,
                    ["oh"] = ranger_open.split,
                    ["ot"] = ranger_open.tabedit,
                    ["or"] = ranger_open.rifle,
                },

                ui = {
                    border = "shadow",
                    width = 1.4,
                    height = 1.4
                }
            })
            vim.api.nvim_set_keymap("n", "<leader>fe", "RangerExplorer", {
                noremap = true,
                callback = function()
                    require("ranger-nvim").open(true)
                end,
            })

            vim.api.nvim_set_keymap("n", "<leader>fe", "RangerPicker", {
                noremap = true,
                callback = function()
                    require("ranger-nvim").open(true)
                end,
            })
        end,
    },
    {
        "luukvbaal/nnn.nvim",
        cmd = {
            "NnnExplorer",
            "NnnPicker"
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        enabled = function()
            if vim.fn.executable('nnn') then
                return true
            end

            return false
        end,

        config = function()
            local nnn = require("nnn")

            nnn.setup({
                explorer = {
                    cmd = "nnn -cxnRH", -- command override (-F1 flag is implied, -a flag is invalid!)
                    width = 28, -- width of the vertical split
                    side = "topleft", -- or "botright", location of the explorer window
                    session = "local", -- or "global" / "local" / "shared"
                    tabs = true, -- separate nnn instance per tab
                    fullscreen = true -- whether to fullscreen explorer window when current tab is empty
                },
                picker = {
                    cmd = "nnn -cxP", -- command override (-p flag is implied)
                    style = {
                        width = 1.0, -- percentage relative to terminal size when < 1, absolute otherwise
                        height = 1.0, -- ^
                        xoffset = 0.5, -- ^
                        yoffset = 0.5, -- ^
                        border = "rounded" -- border decoration for example "rounded"(:h nvim_open_win)
                    },
                    session = "shared", -- or "global" / "local" / "shared"
                    tabs = false, -- separate nnn instance per tab
                    fullscreen = true -- whether to fullscreen picker window when current tab is empty
                },
                auto_open = {
                    setup = "explorer",          -- or "explorer" / "picker", auto open on setup function
                    tabpage = "picker",          -- or "explorer" / "picker", auto open when opening new tabpage
                    empty = false,               -- only auto open on empty buffer
                    ft_ignore = { "gitcommit" }  -- dont auto open for these filetypes
                },
                auto_close = true,               -- close tabpage/nvim when nnn is last window
                replace_netrw = 1,               -- or "explorer" / "picker"
                mappings = {
                    { "<C-t>", nnn.builtin.open_in_tab }, -- open file(s) in tab
                    { "<C-s>", nnn.builtin.open_in_split }, -- open file(s) in split
                    { "<C-v>", nnn.builtin.open_in_vsplit }, -- open file(s) in vertical split
                    { "<C-p>", nnn.builtin.open_in_preview }, -- open file in preview split keeping nnn focused
                    { "<C-y>", nnn.builtin.copy_to_clipboard }, -- copy file(s) to clipboard
                    { "<C-w>", nnn.builtin.cd_to_path }, -- cd to file directory
                    { "<C-e>", nnn.builtin.populate_cmdline } -- populate cmdline (:) with file(s)
                },                               -- table containing mappings, see below
                windownav = {                    -- window movement mappings to navigate out of nnn
                    left = "<C-a>",
                    right = "<C-d>",
                    next = "<C-n>",
                    prev = "<C-p>"
                },
                buflisted = true, -- whether or not nnn buffers show up in the bufferlist
                quitcd = "zd", -- or "cd" / tcd" / "lcd", command to run on quitcd file if found
                offset = true -- whether or not to write position offset to tmpfile(for use in preview-tui)
            })
        end
    },
}
