return {

    {
        "nvim-lualine/lualine.nvim",

        dependencies = {
            "arkav/lualine-lsp-progress",
        },

        opts = function(_, opts)
            local tab_max_length = 24
            table.insert(opts.sections.lualine_x, 2, LazyVim.lualine.cmp_source("codeium"))

            opts.extensions = {}
            -- opts.options = {
            --     -- theme = "",
            --     component_separators = {
            --         left = "",
            --         right = ""
            --     },
            --     disabled_filetypes = { "toggleterm", "terminal" },
            --     section_separators = {
            --         left = "",
            --         right = ""
            --     }
            -- }

            opts.sections = {
                lualine_b = {
                    "branch",
                    {
                        "diff",
                        symbols = {
                            added = "󰐖 ",
                            modified = "󱗜 ",
                            removed = "󰍵 "
                        }
                    }
                },
                lualine_c = {
                    "filename", {
                    "diagnostics",
                    sources = { "nvim_diagnostic" }
                },
                    "lsp_progress"
                }
            }

            opts.tabline = {

                lualine_a = {
                    {
                        "tabs",
                        max_length = vim.o.columns,
                        mode = 2,
                        fmt = function(name)
                            name = string.sub(name, 1, tab_max_length)

                            local padding = tab_max_length - #name
                            local pad_left = math.floor(padding / 2)
                            local pad_right = math.ceil(padding / 2)

                            return string.rep(" ", pad_left) .. name .. string.rep(" ", pad_right)
                        end
                    }
                }

            }
        end
    }
}
