return {

    {
        "lmburns/lf.nvim",
        lazy = (vim.fn.executable('lf') and false) or true,
        priority = (vim.fn.executable('lf') and 5000) or nil,
        cmd = {
            "Lf",
            "LfOpenInDirectory",
        },
        dependencies = { "toggleterm.nvim" },

        enabled = function()
            if vim.fn.executable('lf') then
                return true
            end
            return false
        end,

        setup = function()
            -- This feature will not work if the plugin is lazy-loaded
            vim.g.lf_netrw = 1
        end,

        opts = function()
            local default_opts = {
                border = "shadow",
                winblend = 10,                                               -- psuedotransparency level
                dir = nil,                                                   -- directory where `lf` starts ('gwd' is git-working-directory, ""/nil is CWD)
                tmux = false,                                                -- tmux statusline can be disabled on opening of Lf
                default_file_manager = true,                                 -- make lf default file manager
                disable_netrw_warning = true,                                -- don't display a message when opening a directory with `default_file_manager` as true
                escape_quit = true,                                          -- map escape to the quit command (so it doesn't go into a meta normal mode)
                direction = "vertical",
                default_action = "drop",                                     -- default action when `Lf` opens a file
                height = vim.fn.float2nr(vim.fn.round(0.35 * vim.o.lines)),  -- height of the *floating* window
                width = vim.fn.float2nr(vim.fn.round(0.35 * vim.o.columns)), -- width of the *floating* window
                views = {                                                    -- window dimensions to rotate through
                    { width = 0.800, height = 0.800 },
                    { width = 0.600, height = 0.600 },
                    { width = 0.950, height = 0.950 },
                    { width = 0.500, height = 0.500, col = 0,   row = 0 },
                    { width = 0.500, height = 0.500, col = 0,   row = 0.5 },
                    { width = 0.500, height = 0.500, col = 0.5, row = 0 },
                    { width = 0.500, height = 0.500, col = 0.5, row = 0.5 },
                },
                -- Layout configurations
                layout_mapping = "<M-u>", -- resize window with this key
                highlights = {            -- highlights passed to toggleterm
                    Normal = { link = "Normal" },
                    NormalFloat = { link = 'Normal' },
                    FloatBorder = { guifg = "green", guibg = "black" },
                }
            }

            return default_opts
        end,

        config = function(_, opts)
            local lf = require("lf")

            opts.focus_on_open = true -- focus the current file when opening Lf (experimental)
            opts.mappings = true      -- whether terminal buffer mapping is enabled
            opts.default_actions = {  -- default action keybindings
                ["<C-t>"] = "tabedit",
                ["<C-s>"] = "split",
                ["<C-v>"] = "vsplit",
                ["<C-d>"] = "tab drop",
            }

            lf.setup(opts)
        end

    },

    {
        "kelly-lin/ranger.nvim",
        lazy = (vim.fn.executable('ranger') and false) or true,
        priority = (vim.fn.executable('ranger') and 3000) or nil,
        cmd = {
            "Ranger",
            "RangerExplorer",
            "RangerPicker"
        },
        -- dependencies = {
        --     "nvim-lua/plenary.nvim",
        -- },

        enabled = function()
            if vim.fn.executable('ranger') then
                return true
            end

            return false
        end,

        opts = {
            replace_netrw = true,
            enable_cmds = true,

            ui = {
                border = "shadow",
                x = 0,
                y = 0.8,
                width = 0.3,
                height = 1
            }
        },

        config = function(_, opts)
            local ranger = require("ranger-nvim")
            local ranger_open = ranger.OPEN_MODE
            print(vim.inspect(opts))
            opts.keybinds = {
                ["ov"] = ranger_open.vsplit,
                ["oh"] = ranger_open.split,
                ["ot"] = ranger_open.tabedit,
                ["or"] = ranger_open.rifle,
            }

            ranger.setup(opts)
            vim.api.nvim_set_keymap("n", "<leader>oe", "RangerExplorer", {
                noremap = true,
                callback = function()
                    ranger.open(true)
                end,
            })

            vim.api.nvim_set_keymap("n", "<leader>op", "RangerPicker", {
                noremap = true,
                callback = function()
                    ranger.open(true)
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
            if not vim.fn.executable('lf') and vim.fn.executable('nnn') then
                return true
            end
            return false
        end,

        opts = function()
            local nnn_opts = {
                auto_close = true,      -- close tabpage/nvim when nnn is last window
                replace_netrw = 1,      -- or "explorer" / "picker"
                buflisted = true,       -- whether or not nnn buffers show up in the bufferlist
                quitcd = "zd",          -- or "cd" / tcd" / "lcd", command to run on quitcd file if found
                offset = true,          -- whether or not to write position offset to tmpfile(for use in preview-tui)
                explorer = {
                    cmd = "nnn -cxnRH", -- command override (-F1 flag is implied, -a flag is invalid!)
                    width = 28,         -- width of the vertical split
                    side = "topleft",   -- or "botright", location of the explorer window
                    session = "shared", -- or "global" / "local" / "shared"
                    tabs = true,        -- separate nnn instance per tab
                    fullscreen = true   -- whether to fullscreen explorer window when current tab is empty
                },
                picker = {
                    cmd = "nnn -cxP",      -- command override (-p flag is implied)
                    style = {
                        width = 1.0,       -- percentage relative to terminal size when < 1, absolute otherwise
                        height = 1.0,      -- ^
                        xoffset = 0.5,     -- ^
                        yoffset = 0.5,     -- ^
                        border = "rounded" -- border decoration for example "rounded"(:h nvim_open_win)
                    },
                    session = "global",    -- or "global" / "local" / "shared"
                    tabs = false,          -- separate nnn instance per tab
                    fullscreen = true      -- whether to fullscreen picker window when current tab is empty
                },
                auto_open = {
                    empty = false,      -- only auto open on empty buffer
                    setup = "explorer", -- or "explorer" / "picker", auto open on setup function
                    tabpage = "picker", -- or "explorer" / "picker", auto open when opening new tabpage

                    -- dont auto open for these filetypes
                    ft_ignore = {
                        "gitcommit"
                    }
                },
            }

            return nnn_opts
        end,

        config = function(_, opts)
            local nnn = require("nnn")
            local nnn_builtin = nnn.builtin
            opts.mappings = {
                { "<C-t>", nnn_builtin.open_in_tab },       -- open file(s) in tab
                { "<C-s>", nnn_builtin.open_in_split },     -- open file(s) in split
                { "<C-v>", nnn_builtin.open_in_vsplit },    -- open file(s) in vertical split
                { "<C-p>", nnn_builtin.open_in_preview },   -- open file in preview split keeping nnn focused
                { "<C-y>", nnn_builtin.copy_to_clipboard }, -- copy file(s) to clipboard
                { "<C-w>", nnn_builtin.cd_to_path },        -- cd to file directory
                { "<C-e>", nnn_builtin.populate_cmdline }   -- populate cmdline (:) with file(s)
            }

            -- table containing mappings, see below
            opts.windownav = { -- window movement mappings to navigate out of nnn
                left = "<C-l>",
                right = "<C-j>",
                next = "<C-n>",
                prev = "<C-p>"
            }

            nnn.setup(opts)
        end
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        enabled = function()
            if vim.fn.executable("nnn") or vim.fn.executable("ranger") or vim.fn.executable("lf") then
                return false
            end

            return true
        end,
    }
}
