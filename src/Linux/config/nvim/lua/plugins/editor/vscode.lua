if vim.g.vscode then
    return {}
end
return {
    {
        "unblevable/quick-scope",
        enabled = function()
        end
    },
    {
        "phaazon/hop.nvim",
        name = "hop",
        branch = "v2",
        -- enabled = function()
        -- if vim.g.vscode then
        --     return true
        -- end

        -- return false
        -- end,
        config = function()
            require("hop").setup({})
        end
    },
    {
        "b3nj5m1n/kommentary",
        config = function()
            require("kommentary").config()
        end,
        -- enabled = function()
        --     -- if vim.g.vscode then
        --     --     return true
        --     -- end
        --     return false
        -- end
    }
}
