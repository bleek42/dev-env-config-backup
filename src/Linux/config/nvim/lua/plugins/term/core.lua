return {
    {
        "voldikss/vim-floaterm",
        lazy = true,
        priority = 2000,
        config = function()
            -- configure this neovim lazy config for the vim-floaterm plugin
            require("voldikss/vim-floaterm").setup({})
        end
    },

    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- calling `setup` is optional for customization
            require("fzf-lua").setup({})
        end
    }

}
