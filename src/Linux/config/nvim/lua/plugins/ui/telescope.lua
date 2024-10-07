return {
    {
        "nvim-telescope/telescope.nvim",
        enabled = false,
        lazy = true,
        event = "VeryLazy",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-dap.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "ThePrimeagen/harpoon",
        },

        config = function()
            local actions = require("telescope.actions")
            local keymaps = {}

            keymaps.search = function(actions)
                return {
                    ["<C-d>"] = actions.delete_buffer,
                    ["<C-q>"] = actions.send_to_qflist
                }
            end

            require("telescope").setup({
                defaults = {
                    extensions = {
                        fzf = {
                            fuzzy = true,
                            override_generic_sorter = true,
                            override_file_sorter = true,
                            case_mode = "smart_case"
                        },
                        ["ui-select"] = {
                            require("telescope.themes").get_dropdown({
                                winblend = 10,
                                border = true,
                                previewer = false,
                                layout_config = {
                                    height = 20,
                                    width = 0.5
                                },
                                borderchars = {
                                    prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
                                    results = { " " },
                                    preview = { "─", "─", " ", " ", "─", "─", " ", " " }
                                }
                            })
                        }
                    },
                    mappings = {
                        i = keymaps.search(actions),
                        n = keymaps.search(actions)
                    },
                    layout_strategy = "flex"
                }
            })

            require("telescope").load_extension("dap")
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("ui-select")
            require("telescope").load_extension("harpoon")
        end
    },

    {
        "joshmedeski/telescope-smart-goto.nvim",
        lazy = true,
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "ThePrimeagen/harpoon"
        }
    },

    {
        'ThePrimeagen/harpoon',
        lazy = true,
        branch = "harpoon2",
        opts = {
            menu = {
                width = vim.api.nvim_win_get_width(0) - 4,
            },
            settings = {
                save_on_toggle = true,
            },
        },
        keys = function()
            local keys = {
                {
                    "<leader>H",
                    function()
                        require("harpoon"):list():add()
                    end,
                    desc = "Harpoon File",
                },
                {
                    "<leader>h",
                    function()
                        local harpoon = require("harpoon")
                        harpoon.ui:toggle_quick_menu(harpoon:list())
                    end,
                    desc = "Harpoon Quick Menu",
                },
            }

            for i = 1, 5 do
                table.insert(keys, {
                    "<leader>" .. i,
                    function()
                        require("harpoon"):list():select(i)
                    end,
                    desc = "Harpoon to File " .. i,
                })
            end
            return keys
        end,
    }
}
