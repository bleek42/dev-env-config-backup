return {
    {
        'sainnhe/sonokai',
        lazy = true,
        event = 'VeryLazy',

        setup = function()
            vim.g.sonokai_enable_italic = true
        end,
        opts = {},

        config = function()
            -- vim.cmd('colorscheme sonokai')
        end
    }
}
