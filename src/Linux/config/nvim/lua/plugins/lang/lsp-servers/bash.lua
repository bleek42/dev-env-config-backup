local M = {}
function M.setup(capabilities, on_attach)
    require("lspconfig").bashls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "bash", "sh", "zsh" }
    })
end

return M
