return {
    -- * Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-emoji',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'Exafunction/codeium.nvim'
        },

        ---@diagnostic disable-next-line: undefined-doc-name
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts)
            local cmp = require("cmp")

            table.insert(opts.sources, { name = "emoji", group_index = 0 })
            table.insert(opts.sources, { name = "cmdline", group_index = 0 })
            -- table.insert(opts.sources, { name = "l", group_index = 0 })
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end


            ---@diagnostic disable-next-line: inject-field
            opts.mapping = vim.tbl_extend("force", opts.mapping, {
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        -- ? You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
                        cmp.select_next_item().confirm({ select = true })
                    elseif vim.snippet.active({ direction = 1 }) then
                        vim.schedule(function()
                            vim.snippet.jump(1)
                        end)
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif vim.snippet.active({ direction = -1 }) then
                        vim.schedule(function()
                            vim.snippet.jump(-1)
                        end)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            })

            table.insert(opts.sources, 1, {
                name = "codeium",
                group_index = 1,
                priority = 100,
            })
        end,
    },

    {
        "Exafunction/codeium.nvim",
        cmd = { 'Codeium' },
        build = ':Codeium auth',
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },

        opts = {},

    },

    {
        'hrsh7th/cmp-nvim-lsp'
    },

    {
        'hrsh7th/cmp-buffer'
    },

    {
        'hrsh7th/cmp-path'
    },

    {
        'hrsh7th/cmp-cmdline'
    },

    {
        'hrsh7th/cmp-nvim-lua'
    },

    {
        'hrsh7th/cmp-emoji'
    },
    -- * Snippets
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            "hrsh7th/nvim-cmp",
            "rafamadriz/friendly-snippets"
        }
    },

    {
        "saadparwaiz1/cmp_luasnip"
    },

    {
        "rafamadriz/friendly-snippets"
    },
}
