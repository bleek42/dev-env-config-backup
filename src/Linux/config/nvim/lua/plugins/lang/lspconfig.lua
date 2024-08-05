local lsp_servers = {
    -- awk_ls = {}, -- AWK
    -- angularls = {}, -- Angular
    -- ansiblels = {}, -- Ansible
    -- arduino_language_server = {}, -- Arduino
    -- asm_lsp = {}, -- Assembly (GAS/NASM, GO)
    -- spectral = {}, -- AsyncAPI
    "bashls", -- Bash
    -- beancount = {}, -- Beancount
    -- bicep = {}, -- Bicep
    -- ccls = {}, -- C
    "clangd", -- C, C++
    -- csharp_ls = {}, -- C#
    -- omnisharp = {}, -- C#
    -- ccls = {}, -- C++
    "cmake",         -- CMake
    "cssls",         -- CSS
    "cssmodules_ls", -- CSS
    -- clojure_lsp = {}, -- Clojure
    -- codeqlls = {}, -- CodeQL
    -- crystalline = {}, -- Crystal
    -- scry = {}, -- Crystal
    -- cucumber_language_server = {}, -- Cucumber
    -- dartls = {}, -- Dart
    -- denols = {}, -- Deno
    -- diagnosticls = {}, -- Diagnostic (general purpose server)
    -- serve_d = {}, -- Dlang
    "dockerls", -- Docker
    -- dotls = {}, -- Dot
    -- efm = {}, -- EFM (general purpose server)
    "eslint", -- ESLint
    -- elixirls = {}, -- Elixir
    -- elmls = {}, -- Elm
    -- ember = {}, -- Ember
    "emmet_ls", -- Emmet
    -- erg_language_server = {}, -- Erg
    -- erlangls = {}, -- Erlang
    -- fsautocomplete = {}, -- F#
    -- flux_lsp = {}, -- Flux
    -- foam_ls = {}, -- Foam (OpenFOAM)
    -- fortls = {}, -- Fortran
    -- golangci_lint_ls = {}, -- Go
    -- gopls = {}, -- Go
    -- grammarly = {}, -- Grammarly
    "graphql",  -- GraphQL
    -- groovyls = {}, -- Groovy
    "html",     -- HTML
    -- hls = {}, -- Haskell
    "jsonls ",  -- JSON
    "jdtls  ",  -- Java
    -- quick_lint_js = {}, -- JavaScript
    "tsserver", -- TypeScript
    -- jsonnet_ls = {}, -- Jsonnet
    -- julials = {}, -- Julia
    -- kotlin_language_server = {}, -- Kotlin
    -- ltex = {}, -- LaTeX
    "texlab", -- LaTeX
    -- lelwel_ls = {}, -- Lelwel
    "lua_ls", -- Lua
    -- sumneko_lua = {}, -- Lua
    -- remark_ls = {}, -- Markdown
    -- zeta_note = {}, -- Markdown
    -- zk = {}, -- Markdown
    -- nickel_ls = {}, -- Nickel
    -- nimls = {}, -- Nim
    -- ocamlls = {}, -- OCaml
    -- ccls = {}, -- Objective C
    -- bsl_ls = {}, -- OneScript, 1C:Enterprise
    -- spectral = {}, -- OpenAPI
    -- opencl_ls = {}, -- OpenCL
    -- intelephense = {}, -- PHP
    -- phpactor = {}, -- PHP
    -- psalm = {}, -- PHP
    "powershell_es", -- Powershell
    -- prismals = {},      -- Prisma
    -- puppet = {}, -- Puppet
    -- purescriptls = {}, -- PureScript
    -- jedi_language_server = {}, -- Python
    "pyright", -- Python
    pylsp = {
        settings = {
            pylsp = {
                plugins = {
                    pycodestyle = { maxLineLength = 120 },
                    pyflakes = { enabled = false },
                },
            },
        },
    }, -- Python
    -- rescriptls = {}, -- ReScript
    -- rome = {}, -- Rome
    -- solargraph = {}, -- Ruby
    "rust_analyzer", -- Rust
    "sqlls",         -- SQL
    -- sqls = {}, -- SQL
    -- salt_ls = {}, -- Salt
    -- theme_check = {}, -- Shopify Theme Check
    -- solang = {}, -- Solidity
    -- solc = {}, -- Solidity
    -- solidity_ls = {}, -- Solidity (VSCode)
    -- sorbet = {}, -- Sorbet
    -- esbonio = {}, -- Sphinx
    -- stylelint_lsp = {}, -- Stylelint
    -- svelte = {}, -- Svelte
    -- sourcekit = {}, -- Swift
    -- verible = {}, -- SystemVerilog
    -- taplo = {},       -- TOML
    -- tailwindcss = {}, -- Tailwind CSS
    "terraformls", -- Terraform
    -- tflint = {}, -- Terraform
    -- vala_ls = {}, -- Vala
    "vimls", -- VimL
    -- volar = {}, -- Vue
    -- vuels = {
    --     -- https://stackoverflow.com/questions/65913547/ionic-slot-attributes-are-deprecated-eslint-plugin-vue
    --     init_options = { config = { vetur = { validation = { template = false } } } },
    -- }, -- Vue
    -- lemminx = {}, -- XML
    "yamlls" -- YAML
    -- zls = {}, -- Zig
}

return {

    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            ui = {
                border = "single",
                icons = {
                    package_installed = " ",
                    package_pending = "󰌚 ",
                    package_uninstalled = "󰢤 "
                }
            }
        }

    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
            "VonHeikemen/lsp-zero.nvim"
        },

        config = function()
            local lsp_zero = require("lsp-zero")


            local lsp_handlers = {
                lsp_zero.default_setup,
                rust_analyzer = lsp_zero.noop,

                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require("lspconfig").lua_ls.setup(lua_opts)
                end,



                -- tsserver = lsp_zero.

            }

            require("mason-lspconfig").setup({
                automatic_installation = true,
                ensure_installed = lsp_servers,
                handlers = lsp_handlers
            })
        end
    },

    {
        "VonHeikemen/lsp-zero.nvim",
        -- branch = "v3.x",
        lazy = true,
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },

        config = false,
        -- init = function()
        --     -- Disable automatic setup, we are doing it manually
        --     -- vim.g.lsp_zero_extend_cmp = 0
        --     -- vim.g.lsp_zero_extend_lspconfig = 0
        -- end,

    },

    {
        "neovim/nvim-lspconfig",
        cmd = {
            "LspInfo",
            "LspInstall",
            "LspUninstall"
        },
        event = {
            "BufReadPost",
            "BufNewFile"
        },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "VonHeikemen/lsp-zero.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "mrcjkb/rustaceanvim",
            "folke/neoconf.nvim",
            "folke/neodev.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "j-hui/fidget.nvim",
        },

        config = function()
            local lspconfig = require("lspconfig")
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()
            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({ buffer = bufnr })
            end)

            -- (Optional) Configure lua language server for neovim
            -- local lua_opts = lsp_zero.nvim_lua_ls()
            vim.g.rustaceanvim = {
                server = {
                    capabilities = lsp_zero.get_capabilities(),
                }
            }


            for _, server in pairs(servers) do
                lspconfig.setup(server, function()
                    local keymaps = require("lazyvim.plugins.lsp.keymaps").get()
                    print("LSP: " .. server.name .. " ready!")
                end)
            end
        end,

        opts = {

            -- LSP Server Settings
            ---@type lspconfig.options
            servers = {
                "luals",
                "bashls",
                "shfmt"
            },

            settings = {
                --? mason = false, -- set to false if you don"t want this server to be installed with mason
                --? Use this to add any additional keymaps
                --? for specific lsp servers
                --?-@type LazyKeysSpec[]
                --? keys = {},
            }
        },

    },

    -- Extra lsp features
    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason-lspconfig.nvim",
            "nvim-treesitter/nvim-treesitter", -- optional
            "nvim-tree/nvim-web-devicons"      -- optional
        },

        config = function()
            require("lspsaga").setup(
                {
                    lightbulb = {
                        sign = true
                    },
                    ui = {
                        border = "rounded"
                    }
                }
            )
        end
    },
    -- {
    --     "folke/neodev.nvim",
    --     opts = {}
    -- },
    -- {
    --     "folke/neoconf.nvim",
    --     cmd = "Neoconf",
    --     config = false,
    --     dependencies = {
    --         "nvim-lspconfig"
    --     }
    -- },

    {
        "ray-x/lsp_signature.nvim",
        event = "BufReadPost",
        config = function()
            require("lsp_signature").setup({
                max_height = 6,
                zindex = 1,
                extra_trigger_chars = { "(", ",", "\n" },
            })
        end
    },

    --! Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "L3MON4D3/LuaSnip",
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require("cmp")
            local cmp_action = lsp_zero.cmp_action()

            cmp.setup({
                formatting = lsp_zero.cmp_format({ details = true }),
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                    ["<C-b>"] = cmp_action.luasnip_jump_backward(),
                })
            })
        end
    },

    { "hrsh7th/cmp-nvim-lsp" },
    { "L3MON4D3/LuaSnip" },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-emoji"
        },
    },

    {
        "ms-jpq/coq_nvim",
        enabled = false,
        branch = "coq",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "ms-jpq/coq.artifacts",
            "ms-jpq/coq.thirdparty",
        },
        config = function()
            require("coq").setup({})
        end,

    },

    {
        "ms-jpq/coq.artifacts",
        enabled = false,
        branch = "artifacts"
    },

    {
        "ms-jpq/coq.thirdparty",
        enabled = false,
        branch = "3p"
    },

}
