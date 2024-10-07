return {

    {
        "hardhackerlabs/theme-vim",
        name = "hardhacker",
        lazy = false,
        priority = 1000,

        setup = function()
            -- local opts = {
            --     transparent = false,
            --     style = {
            --         "dark",
            --         "darker"
            --     }
            -- }

            -- custom highlights
            -- vim.g.hardhacker_custom_highlights = {}
            -- opts.style == "darker" then
            vim.g.hardhacker_darker = 1
            -- else
            -- end

            vim.g.hardhacker_hide_tilde = 1
            vim.g.hardhacker_keyword_italic = 1

        end,

        -- config = function(_, opts)
        --     -- vim.cmd("colorscheme hardhacker")
        -- end
    },

    {
        "NTBBloodbath/doom-one.nvim",
        lazy = true,
        event = "VeryLazy",

        init = function()
            -- Add color to cursor
            vim.g.doom_one_cursor_coloring = false
            -- Set :terminal colors
            vim.g.doom_one_terminal_colors = true
            -- Enable italic comments
            vim.g.doom_one_italic_comments = false
            -- Enable TS support
            vim.g.doom_one_enable_treesitter = true
            -- Color whole diagnostic text or only underline
            vim.g.doom_one_diagnostics_text_color = false
            -- Enable transparent background
            vim.g.doom_one_transparent_background = true

            -- Pumblend transparency
            -- vim.g.doom_one_pumblend_enable = true
            -- vim.g.doom_one_pumblend_transparency = 10

            -- Plugins integration
            vim.g.doom_one_plugin_neorg = true
            vim.g.doom_one_plugin_barbar = false
            vim.g.doom_one_plugin_telescope = true
            vim.g.doom_one_plugin_neogit = true
            vim.g.doom_one_plugin_nvim_tree = true
            vim.g.doom_one_plugin_dashboard = true
            vim.g.doom_one_plugin_startify = true
            vim.g.doom_one_plugin_whichkey = true
            vim.g.doom_one_plugin_indent_blankline = true
            vim.g.doom_one_plugin_vim_illuminate = true
            vim.g.doom_one_plugin_lspsaga = true
        end,
        -- opts = {},
        -- config = function(_, opts)

        --     -- vim.cmd("colorscheme doom-one")
        -- end

    },

    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,

        opts = {
            -- Enable transparent background
            transparent = false,

            -- Enable italics comments
            italic_comments = true,

            -- Replace all fillchars with ' ' for the ultimate clean look
            hide_fillchars = true,

            -- Modern borderless telescope theme - also applies to fzf-lua
            borderless_telescope = true,

            -- Set terminal colors used in `:terminal`
            terminal_colors = true,

            -- Use caching to improve performance - WARNING: experimental feature - expect the unexpected!
            -- Early testing shows a 60-70% improvement in startup time. YMMV. Disables dynamic light/dark theme switching.
            cache = false, -- generate cache with :CyberdreamBuildCache and clear with :CyberdreamClearCache

            theme = {
                variant = "default", -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`
                -- highlights = {
                --     -- Highlight groups to override, adding new groups is also possible
                --     -- See `:h highlight-groups` for a list of highlight groups or run `:hi` to see all groups and their current values

                --     -- Example:
                --     Comment = { fg = "#696969", bg = "NONE", italic = true },

                --     -- Complete list can be found in `lua/cyberdream/theme.lua`
                -- },

                -- -- Override a highlight group entirely using the color palette
                -- overrides = function(colors) -- NOTE: This function nullifies the `highlights` option
                --     -- Example:
                --     return {
                --         Comment = { fg = colors.green, bg = "NONE", italic = true },
                --         ["@property"] = { fg = colors.magenta, bold = true },
                --     }
                -- end,

                -- Override a color entirely
                -- colors = {
                --     -- For a list of colors see `lua/cyberdream/colours.lua`
                --     -- Example:
                --     bg = "#000000",
                --     green = "#00ff00",
                --     magenta = "#ff00ff",
                -- },
            },

            -- Disable or enable colorscheme extensions
            extensions = {
                cmp = true,
                dashboard = true,
                fzflua = true,
                gitsigns = true,
                helpview = true,
                hop = true,
                indentblankline = true,
                kubectl = true,
                lazy = true,
                leap = true,
                markdown = true,
                markview = true,
                mini = true,
                noice = true,
                neogit = true,
                notify = true,
                rainbow_delimiters = true,
                telescope = true,
                treesitter = true,
                treesittercontext = true,
                trouble = true,
                whichkey = true
            },
        },


        config = function(_, opts)
            require("cyberdream").setup(opts)
            -- vim.cmd("colorscheme cyberdream")
        end,
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 3000,
        setup = function()
            vim.g.catppuccin_flavour = "mocha"
        end,

        -- opts = {},
        -- config = function(_, opts)
        --     -- vim.cmd("colorscheme catppuccin")
        -- end
    },



    {
        "navarasu/onedark.nvim",
        name = "onedark",
        lazy = false,
        priority = 2000,

        opts = {
            style = "cool",
            transparent = true,
            transparent_sidebar = false
        },
        config = function(_, opts)
            require("onedark").setup(opts)
            -- require("onedark").load();
            -- vim.cmd("colorscheme onedark")
        end
    }
}
