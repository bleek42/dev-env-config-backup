return {

    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        lazy = false,
        priority = 2000,
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },

        opts = function(_, opts)
            -- local opts = {}
            -- local neovimHeader = [[
            --       ⠀⠀⠀⣠⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            --       ⠀⣴⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣶⣶⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            --       ⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            --       ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⢹⣀⠶⠋⠉⠙⢿⣄⠀⠀⣠⡾⠋⠉⠉⠛⣦⠀⠀⣠⡾⠛⠉⠉⠛⣶⡀⠙⣿⣿⠀⠀⠀⠀⣿⣿⡟⢸⣿⣿⠀⢸⣿⣿⣿⠿⠿⣿⣿⣶⣿⠿⢿⣿⣿⡄
            --       ⣿⣿⣿⣿⣿⠙⣿⣿⣿⣿⣿⣆⠀⠀⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⢹⡇⠀⠀⠀⠀⠀⣿⠀⢸⣏⣀⣀⣀⣀⣀⣈⡇⢰⡟⠀⠀⠀⠀⠀⠀⣿⡀⠹⣿⣿⠀⠀⣾⣿⡟⠀⢸⣿⣿⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿⠀⠀⠀⣿⣿⣿
            --       ⣿⣿⣿⣿⣿⠀⠈⢿⣿⣿⣿⣿⣷⠀⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⢹⡇⠀⠀⠀⠀⠀⣿⠀⢿⡇⠀⠀⠀⠀⠀⠀⠀⢹⡇⠀⠀⠀⠀⠀⠀⣿⡇⠀⢻⣿⣷⣰⣿⡿⠀⠀⢸⣿⣿⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿⠀⠀⠀⣿⣿⣿
            --       ⣿⣿⣿⣿⣿⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⢹⡇⠀⠀⠀⠀⠀⣿⠀⠈⣿⡀⠀⠀⠀⠀⠀⠀⠈⣿⡀⠀⠀⠀⠀⣠⡿⠀⠀⠀⢿⣿⣿⣿⠀⠀⠀⢸⣿⣿⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿⠀⠀⠀⣿⣿⣿
            --       ⣿⣿⣿⣿⣿⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠙⠁⠀⠀⠀⠀⠀⠛⠀⠀⠀⠉⠛⠛⠛⠋⠁⠀⠀⠀⠉⠛⠛⠛⠋⠁⠀⠀⠀⠀⠀⠉⠉⠀⠀⠀⠀⠈⠛⠛⠀⠈⠛⠛⠀⠀⠀⠘⠛⠛⠀⠀⠀⠙⠛⠋
            --       ⠙⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            --       ⠀⠀⠈⢿⣿⠀⠀⠀⠀⠀⠀⠀⠉⣿⣿⡿⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            --       ⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            --       ]]

            -- local doomHeader =
            -- local builtin = require("nnn").builtin

            -- local file_explorer_cmds = {

            -- },
            -- local function file_explorer()
            --     return vim.fn.executable('nnn') and "NnnExplorer" or
            --         vim.fn.executable('ranger') and 'Ranger' or
            --         vim.fn.executable('lf') and 'Lf' or 'Telescope'
            -- end


            opts.config.header = {
                "                                                                              ",
                "=================     ===============     ===============   ========  ========",
                "\\\\ . . . . . . .\\\\   //. . . . . . .\\\\   //. . . . . . .\\\\  \\\\. . .\\\\// . . //",
                "||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\\/ . . .||",
                "|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||",
                "||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||",
                "|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\\ . . . . ||",
                "||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\\_ . .|. .||",
                "|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\\ `-_/| . ||",
                "||_-' ||  .|/    || ||    \\|.  || `-_|| ||_-' ||  .|/    || ||   | \\  / |-_.||",
                "||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \\  / |  `||",
                "||    `'         || ||         `'    || ||    `'         || ||   | \\  / |   ||",
                "||            .===' `===.         .==='.`===.         .===' /==. |  \\/  |   ||",
                "||         .=='   \\_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \\/  |   ||",
                "||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \\/  |   ||",
                "||   .=='    _-'          `-__\\._-'         `-_./__-'         `' |. /|  |   ||",
                "||.=='    _-'                                                     `' |  /==.||",
                "=='    _-'                    {{ L A Z Y V I M }}                       \\/   `==",
                "\\   _-'                                                                `-_   /",
                " `''                                                                      ``''",
            }


            opts.config.center = {

                {
                    key = "e",
                    icon = " ",
                    desc = "File Explorer",
                    action = "Lf"
                },

                {
                    key = "f",
                    icon = " ",
                    desc = "Find file",
                    action = "FzfLua",
                },

                {
                    key = "r",
                    icon = " ",
                    desc = " Recent files",
                    action = "Telescope oldfiles"
                },

                -- { keymap = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
                {
                    key = "n",
                    icon = " ",
                    desc = "New file",
                    action = "ene | startinsert",
                },

                {
                    key = "c",
                    desc = "Config",
                    icon = " ",
                    action = "LazyConfig"
                },

                {
                    key = "s",
                    icon = " ",
                    desc = " Restore Session",
                    action = [[lua require("persistence").load()]]
                },

                {
                    key = "x",
                    icon = " ",
                    desc = " Lazy Extras",
                    action = "LazyExtras"
                },

                {
                    key = "l",
                    icon = "󰒲 ",
                    desc = " Lazy",
                    keymap = "Lazy"
                },

                {
                    key = "Q",
                    icon = " ",
                    desc = "Quit",
                    keymap = "qall"
                }
            }



            opts.config.footer = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                return { "(( ⚡ Neovim loaded " ..
                stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms ))" }
            end

            for _, button in ipairs(opts.config.center) do
                button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
                button.key_format = "  %s"
            end

            -- open dashboard after closing lazy
            if vim.o.filetype == "lazy" then
                vim.api.nvim_create_autocmd("WinClosed", {
                    pattern = tostring(vim.api.nvim_get_current_win()),
                    once = true,
                    callback = function()
                        vim.schedule(function()
                            vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
                        end)
                    end,
                })
            end

            return opts
            -- require("dashboard").setup(opts)
        end
    }

}
