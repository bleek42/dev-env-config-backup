return {
    {
        'nyoom-engineering/oxocarbon.nvim',
        name = 'oxocarbon',
        lazy = true,
        event = 'VeryLazy',

        setup = function()
            vim.opt.background = "dark" -- set this to dark or light
        end,

        opts = {},

        config = function(_, opts)
            -- vim.cmd("colorscheme oxocarbon")
        end,
    }
}
