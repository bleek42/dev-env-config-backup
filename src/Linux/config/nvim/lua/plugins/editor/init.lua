return {

    {
        "folke/todo-comments.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        cmd = {
            "TodoTrouble",
            "TodoTelescope",
            "TodoLocList",
            "TodoQuickFix"
        },
    },

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = {
            "Trouble",
            "TroubleToggle"
        },

        -- config = function()
        --     local keymaps = {}
        --     keymaps.diagnostics = {
        --         ["close"] = "q",
        --         ["cancel"] = "c",
        --         ["refresh"] = "r",
        --         ["jump"] = "j",
        --         ["hover"] = "h",
        --         ["toggle_fold"] = "<space>",
        --         ["previous"] = "<C-p>",
        --         ["next"] = "<C-n>"
        --     }

        --     vim.cmd([[autocmd WinEnter * if winnr('$') == 1 && &ft == 'Trouble' | q | endif]])

        --     require("trouble").setup(
        --         {
        --             use_diagnostic_signs = true,
        --             action_keys = keymaps.diagnostics
        --         }
        --     )
        -- end
    },

    {
        "echasnovski/mini.move",
        -- opts = {},
        -- keys = {}
    },

    {
        "echasnovski/mini.surround",
        opts = {
            n_lines = 200
        },
        -- keys = {
        --     {
        --         "sa",
        --         desc = "Add surrounding",
        --         mode = { "n", "v" }
        --     },
        --     {
        --         "sd",
        --         desc = "Delete surrounding"
        --     },
        --     {
        --         "sf",
        --         desc = "Find right surrounding"
        --     },
        --     {
        --         "sF",
        --         desc = "Find left surrounding"
        --     },
        --     {
        --         "sh",
        --         desc = "Highlight surrounding"
        --     },
        --     {
        --         "sr",
        --         desc = "Replace surrounding"
        --     },
        --     {
        --         "sn",
        --         desc = "Update `MiniSurround.config.n_lines`"
        --     }
        -- }
    },

    {
        "lewis6991/gitsigns.nvim",
        -- opts = {
        --     signcolumn = false,
        --     numhl = true,
        --     current_line_blame_opts = {
        --         ignore_whitespace = true
        --     }
        -- }
    },

    {
        "wakatime/vim-wakatime",
        enabled = false,
        config = function()
            local wakatime = require("wakatime")
            wakatime.setup({})
        end
    },

    {
        "norcalli/nvim-colorizer.lua",
    },

    {
        "lukas-reineke/headlines.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        ft = { "markdown" }
    },

    {
        "907th/vim-auto-save",
        enabled = false
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            indent = {
                char = "▏"
            }
        }
    },

    {
        "folke/flash.nvim",
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
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons"
        }

        -- opts = {},
    },

    {
        "nacro90/numb.nvim",
        -- config = function()
        --     require("numb").setup({})
        -- end
    },

    {
        "lambdalisue/suda.vim",
    },

    {
        "junegunn/vim-easy-align"
    },

    -- Use local .editorconfig files
    {
        "gpanders/editorconfig.nvim"
    }

}
