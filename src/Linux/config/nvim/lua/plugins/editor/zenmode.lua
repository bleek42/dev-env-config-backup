return {

    {
        "folke/zen-mode.nvim",
        name = "zen-mode",
        cmd = {
            "ZenMode"
        },
        opts = {
            window = {
                backdrop = 1,
                width = function()
                    return math.min(120, vim.o.columns * 0.75)
                end,
                height = 0.9,
                options = {
                    number = false,
                    relativenumber = false,
                    foldcolumn = "0",
                    list = false,
                    showbreak = "NONE",
                    signcolumn = "no"
                }
            },
            plugins = {
                options = {
                    cmdheight = 1,
                    laststatus = 1
                }
            },
            on_open = function()
                -- disable diagnostics, indent blankline, and winbar
                vim.g.diagnostics_mode_old = vim.g.diagnostics_mode
                vim.g.indent_blankline_enabledd_old = vim.g.indent_blankline_enabledd
                vim.g.winbar_old = vim.wo.winbar
                vim.g.diagnostics_mode = 0
                vim.g.indent_blankline_enabledd = false
                vim.wo.winbar = nil
            end,
            on_close = function()
                -- restore diagnostics, indent blankline, and winbar
                vim.g.diagnostics_mode = vim.g.diagnostics_mode_old
                vim.g.indent_blankline_enabledd = vim.g.indent_blankline_enabledd_old
                vim.wo.winbar = vim.g.winbar_old
            end
        }
    }

}
