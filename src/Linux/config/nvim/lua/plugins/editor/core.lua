return {
    {
        "folke/todo-comments.nvim",
        name = "todo-comments",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        cmd = {
            "TodoTrouble",
            "TodoTelescope",
            "TodoLocList",
            "TodoQuickFix"
        },
        -- opts = {},
        config = function()
            require("todo-comments").setup({})
        end
    },

    {
        "folke/trouble.nvim",
        name = "trouble",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = {
            "Trouble",
            "TroubleToggle"
        },
        config = function()
            local keymaps = {}
            keymaps.diagnostics = {
                ["close"] = "q",
                ["cancel"] = "c",
                ["refresh"] = "r",
                ["jump"] = "j",
                ["hover"] = "h",
                ["toggle_fold"] = "<space>",
                ["previous"] = "<C-p>",
                ["next"] = "<C-n>"
            }

            vim.cmd([[autocmd WinEnter * if winnr('$') == 1 && &ft == 'Trouble' | q | endif]])

            require("trouble").setup(
                {
                    use_diagnostic_signs = true,
                    action_keys = keymaps.diagnostics
                }
            )
        end
    },

    {
        "nvim-pack/nvim-spectre",
        cmd = "Spectre",
        opts = function()
            local prefix = "<leader>s"
            return {
                open_cmd = "new",
                mapping = {
                    send_to_qf = {
                        map = prefix .. "q"
                    },
                    replace_cmd = {
                        map = prefix .. "c"
                    },
                    show_option_menu = {
                        map = prefix .. "o"
                    },
                    run_current_replace = {
                        map = prefix .. "C"
                    },
                    run_replace = {
                        map = prefix .. "R"
                    },
                    change_view_mode = {
                        map = prefix .. "v"
                    },
                    resume_last_search = {
                        map = prefix .. "l"
                    }
                }
            }
        end
    },

    {
        "echasnovski/mini.move",
        keys = {
            {
                "<M-l>",
                mode = { "n", "v" }
            },
            {
                "<M-k>",
                mode = { "n", "v" }
            },
            {
                "<M-j>",
                mode = { "n", "v" }
            },
            {
                "<M-h>",
                mode = { "n", "v" }
            }
        },
        -- opts = {}
    },

    {
        "echasnovski/mini.surround",
        opts = {
            n_lines = 200
        },
        keys = {
            {
                "sa",
                desc = "Add surrounding",
                mode = { "n", "v" }
            },
            {
                "sd",
                desc = "Delete surrounding"
            },
            {
                "sf",
                desc = "Find right surrounding"
            },
            {
                "sF",
                desc = "Find left surrounding"
            },
            {
                "sh",
                desc = "Highlight surrounding"
            },
            {
                "sr",
                desc = "Replace surrounding"
            },
            {
                "sn",
                desc = "Update `MiniSurround.config.n_lines`"
            }
        }
    },

    {
        "lewis6991/gitsigns.nvim",
        name = "gitsigns",
        opts = {
            signcolumn = false,
            numhl = true,
            current_line_blame_opts = {
                ignore_whitespace = true
            }
        }
    },

    {
        "wakatime/vim-wakatime",
        enabled = false,
        config = function()
            local waka_time = require("wakatime")
            waka_time.setup({})
        end
    },

    {
        "norcalli/nvim-colorizer.lua",
        name = "nvim-colorizer",
        config = function()
            require("colorizer").setup()
        end
    },

    {
        "lukas-reineke/headlines.nvim",
        name = "headlines",
        enabled = false,
        dependencies = "nvim-treesitter/nvim-treesitter",
        ft = "markdown"
    },

    {
        "907th/vim-auto-save",
        enabled = false,
        -- config = function()
        --     vim.g.auto_save = 0
        -- end
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = {
                char = "▏"
            }
        }
    },

    {
        "folke/flash.nvim",
        name = "flash",
        event = "VeryLazy",
        -- @type Flash.Config
        opts = {
            modes = {
                char = {
                    jump_labels = true
                }
            }
        }
    },

    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons"
        }

        -- opts = {},
    },

    {
        "nacro90/numb.nvim",
        name = "numb",
        config = function()
            require("numb").setup()
        end
    },

    {
        "lambdalisue/suda.vim",
        name = "suda"
    },

    { "junegunn/vim-easy-align" },

    -- Use local .editorconfig files
    {
        "gpanders/editorconfig.nvim",
        name = "editorconfig"
    },
}
