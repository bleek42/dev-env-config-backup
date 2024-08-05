local M = {}
function M.setup(capabilities, on_attach)
    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    require("lspconfig").lua_ls.setup({
        cmd = { "lua-language-server" },
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                    path = runtime_path,
                },
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    vim.env.VIMRUNTIME,
                },
                telemetry = {
                    enabled = false,
                },
            },
        },
    })
end

return M
