return {
    {
        "folke/tokyonight.nvim",
        name = "tokyonight",
        lazy = true,
        event = 'VeryLazy',
        opts = {
            style = "storm",
            transparent = false
        },

        -- config = function(_, opts)
        --     require("tokyonight").setup(opts)

        --     -- vim.cmd.colorscheme("tokyonight")
        -- end
    }
}
