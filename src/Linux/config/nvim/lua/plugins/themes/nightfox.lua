return {
    {
        "edeneast/nightfox.nvim",
        name = "nightfox",
        lazy = true,
        event = 'VeryLazy',

        opts = {},
        config = function()
            vim.cmd.colorscheme("nightfox")
        end

    }
}
