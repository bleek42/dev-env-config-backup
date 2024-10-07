return {
    {
        'mfussenegger/nvim-dap',
        recommended = true,
        lazy = true,
        event = "VeryLazy",
        desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",
        dependencies = {
            { 'rcarriga/nvim-dap-ui' },
            { "jay-babu/mason-nvim-dap.nvim" },
            { dir = "daps.rust" },
            { dir = "daps.dotnet" },
        },

        -- keys = {
        --     { "<leader>d",  "",                                                                                   desc = "+debug",                 mode = { "n", "v" } },
        --     { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
        --     { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
        --     { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
        --     { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
        --     { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
        --     { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
        --     { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
        --     { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
        --     { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
        --     { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
        --     { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
        --     { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
        --     { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
        --     { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
        --     { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
        --     { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
        --     { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
        -- },

        -- init = function()
        --     local daps = {
        --         require('daps.rust'),
        --         require('daps.dotnet')
        --     }

        --     print(daps)

        --     return daps
        -- end,

        -- config = function(_, opts)
        --     print(vim.inspect(opts))
        --     local dap = require("dap")
        --     local dapui = require("dapui")
        --     local json = require("plenary.json")
        --     local vsc = require("dap.ext.vsccode")

        --     local daps = opts.daps
        --     -- load mason-nvim-dap here, after all adapters have been setup
        --     if LazyVim.has("mason-nvim-dap.nvim") then
        --         require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
        --     end

        --     vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
        --     -- if LazyVim.config.icons.dap ~= nil and LazyVumi.config.icons.dap.length() ~= nil then
        --     for name, sign in pairs(LazyVim.config.icons.dap) do
        --         sign = type(sign) == "table" and sign or { sign }
        --         vim.fn.sign_define(
        --             "Dap" .. name,
        --             { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        --         )
        --     end

        --     for _, server in pairs(daps) do
        --         if server ~= nil then
        --             server.setup()
        --         end
        --     end

        --     vsc.load_launchjs(nil, {})
        --     dapui.setup()

        --     -- setup dap config by VS Code launch.json file
        --     vsc.json_decode = function(str)
        --         return vim.json.decode(json.json_strip_comments(str))
        --     end

        --     -- Extends dap.configurations with entries read from .vscode/launch.json
        --     if vim.fn.filereadable(".vsccode/launch.json") then
        --         vsc.load_launchjs()
        --     end

        --     dap.listeners.after.event_initialized["dapui_config"] = function()
        --         dapui.open()
        --     end
        --     dap.listeners.before.event_terminated["dapui_config"] = function()
        --         dapui.close()
        --     end
        --     dap.listeners.before.event_exited["dapui_config"] = function()
        --         dapui.close()
        --     end
        -- end
    },

    {
        'rcarriga/nvim-dap-ui',
        dependencies = { "nvim-neotest/nvim-nio" },
        -- stylua: ignore
        -- keys = {
        --     { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
        --     { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
        -- },
        -- opts = {},
        -- config = function(_, opts)
        --     local dap = require("dap")
        --     local dapui = require("dapui")
        --     dapui.setup(opts)
        --     dap.listeners.after.event_initialized["dapui_config"] = function()
        --         dapui.open({})
        --     end
        --     dap.listeners.before.event_terminated["dapui_config"] = function()
        --         dapui.close({})
        --     end
        --     dap.listeners.before.event_exited["dapui_config"] = function()
        --         dapui.close({})
        --     end
        -- end,
    },

    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "williamboman/mason.nvim"
        },
        -- cmd = { "DapInstall", "DapUninstall" },
        -- opts = {
        --     -- Makes a best effort to setup the various debuggers with
        --     -- reasonable debug configurations
        --     automatic_installation = true,

        --     -- You can provide additional configuration to the handlers,
        --     -- see mason-nvim-dap README for more information
        --     -- handlers = {},

        --     -- You'll need to check that you have the required things installed
        --     -- online, please don't ask me how to install them :)
        --     ensure_installed = {
        --         -- Update this to ensure that you have the debuggers for the langs you want
        --     },
        -- },
        -- -- mason-nvim-dap is loaded when nvim-dap loads
        -- -- config = function() end,
    },

    {
        "nvim-neotest/neotest",
        optional = true,
        opts = {
            adapters = {
                ["rustaceanvim.neotest"] = {},
            },
        },
    },

    {
        "theHamsta/nvim-dap-virtual-text"
    },
}
