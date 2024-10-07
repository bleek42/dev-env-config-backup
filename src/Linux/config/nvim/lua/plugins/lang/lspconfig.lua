return {

    {
        '  "williamboman/mason.nvim'
    },

    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                'lua_ls',
                'cssls',
                'emmet_ls',
                'eslint',
                'bashls',
                'biome'
            }
        }
        -- lazy = true,
        -- function()
        -- local mason_lspconfig = require("mason-lspconfig")
        -- local lspconfig = require('lspconfig')
        -- local lsp_zero = require('lsp-zero')
        -- local lsp_cmp = require('cmp_nvim_lsp')

        --     local servers = {
        --     }
        -- end

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
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "folke/neoconf.nvim",
            "folke/neodev.nvim",
            "pmizio/typescript-tools.nvim",
            "mrcjkb/rustaceanvim"
        },

        opts = function()
            local keymaps = require("lazyvim.plugins.lsp.keymaps").get()

            ---@class PluginLspOpts
            local lsp_opts = {

                -- options for vim.diagnostic.config()
                ---@type vim.diagnostic.Opts
                diagnostics = {
                    underline = true,
                    update_in_insert = false,
                    virtual_text = {
                        spacing = 2,
                        source = "if_many",
                        prefix = "●",
                        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
                        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
                        -- prefix = "icons",
                    },
                    severity_sort = true,

                },
                -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
                -- Be aware that you also will need to properly configure your LSP server to
                -- provide the inlay hints.
                inlay_hints = {
                    enabled = true,
                    -- exclude = {}, -- filetypes for which you don't want to enable inlay hints
                },
                -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
                -- Be aware that you also will need to properly configure your LSP server to
                -- provide the code lenses.
                codelens = {
                    enabled = true,
                },
                -- Enable lsp cursor word highlighting
                document_highlight = {
                    enabled = true,
                },
                -- add any global capabilities here
                capabilities = {
                    workspace = {
                        fileOperations = {
                            didRename = true,
                            willRename = true,
                        },
                    },
                },
                -- options for vim.lsp.buf.format
                -- `bufnr` and `filter` is handled by the LazyVim formatter,
                -- but can be also overridden when specified
                format = {
                    formatting_options = nil,
                    timeout_ms = nil,
                },

                ---@type lspconfig.options
                servers = {
                    lua_ls = {
                        settings = {
                            Lua = {
                                runtime = {
                                    version = "LuaJIT",
                                    path = vim.split(package.path, ";"),
                                },
                                diagnostics = {
                                    globals = { "vim", "LazyVim" },
                                },
                                telemetry = {
                                    enabled = false,
                                },
                            },
                        },
                    },

                    bashls = {
                        filetypes = {
                            "zsh",
                            "bash",
                            "sh"
                        }
                    },

                    jsonls = {},

                    html = {},

                    cssls = {},

                    emmet_ls = {},

                    tsserver = {},

                    eslint = {},

                    biome = {},

                    -- nix = {},

                    -- terraform = {}

                },

                ---@type table<string, fun(server:string, opts:lspconfig.options):boolean?>
                setup = {

                    -- function(server, opts)
                    --     server.setup(opts)
                    -- end,

                    biome = function(server, opts)
                        print('lsp:' .. server)
                    end,

                    -- eslint = function(server, opts)
                    --     require("lazyvim.util").lsp.on_attach(function(client)
                    --         if client.name == "eslint" then
                    --             client.server_capabilities.documentFormattingProvider = true
                    --         elseif client.name == "tsserver" then
                    --             client.server_capabilities.documentFormattingProvider = false
                    --         end
                    --     end)
                    -- end,
                    tsserver = function(server, opts)
                        -- disable tsserver
                        print('lsp:' .. server)

                        local formatter = LazyVim.lsp.formatter({
                            name = 'biome: lsp',
                            primary = false,
                            priority = 100,
                            filter = 'biome'
                        })

                        -- register the formatter with LazyVim
                        LazyVim.format.register(formatter)

                        -- print(vim.inspect(opts))

                        local has_ts_tools, ts_tools = pcall(require, "typescript-tools")
                        if has_ts_tools then
                            print('disabled tsserver; using typescript-tools')
                            -- ts_tools.setup(opts)
                            return false
                        end



                        return true
                    end,

                    -- bashls = function(server, opts)
                    --     -- local function get_client(buf)
                    --     --     return LazyVim.lsp.get_clients({ name = "bashls", bufnr = buf })[1]
                    --     -- end

                    --     -- print('lsp:' .. server)
                    --     -- print(vim.inspect(opts))

                    --     local formatter = LazyVim.lsp.formatter({
                    --         name = "shfmt: lsp",
                    --         primary = false,
                    --         priority = 200,
                    --         filter = "shfmt"
                    --     })

                    --     -- register the formatter with LazyVim
                    --     LazyVim.format.register(formatter)
                    --     -- end,
                    -- end,

                }
            }

            return lsp_opts
        end,
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

        opts = {
            lightbulb = {
                sign = true
            },
            ui = {
                border = "rounded"
            }
        },

        config = function(_, opts)
            print(opts)
            require("lspsaga").setup(opts)
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
            local opts = {
                max_height = 6,
                zindex = 1,
                extra_trigger_chars = { "(", ",", "\n" },
            }
            require("lsp_signature").setup(opts)
        end
    },

    {
        "williamboman/mason.nvim",
    }
    -- {
    --     'hrsh7th/nvim-cmp',
    --     event = 'InsertEnter',
    --     dependencies = {
    --         'L3MON4D3/LuaSnip',
    --         'VonHeikemen/lsp-zero.nvim'
    --     },

    --     config = function()
    --         -- Here is where you configure the autocompletion settings.
    --         local lsp_zero = require("lsp-zero")
    --         local cmp = require("cmp")
    --         lsp_zero.extend_cmp()

    --         -- And you can configure cmp even more, if you want to.
    --         local cmp_action = lsp_zero.cmp_action()

    --         cmp.setup({
    --             formatting = lsp_zero.cmp_format({ details = true }),
    --             mapping = cmp.mapping.preset.insert({
    --                 ["<C-Space>"] = cmp.mapping.complete(),
    --                 ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    --                 ["<C-d>"] = cmp.mapping.scroll_docs(4),
    --                 ["<C-f>"] = cmp_action.luasnip_jump_forward(),
    --                 ["<C-b>"] = cmp_action.luasnip_jump_backward(),
    --             })
    --         })
    --     end
    -- },

    -- {

    -- },

    -- {
    --     "ms-jpq/coq_nvim",
    --     enabled = false,
    --     branch = "coq",
    --     event = { "BufReadPost", "BufNewFile" },
    --     dependencies = {
    --         "williamboman/mason-lspconfig.nvim",
    --         "neovim/nvim-lspconfig",
    --         "ms-jpq/coq.artifacts",
    --         "ms-jpq/coq.thirdparty",
    --     },

    --     config = function()
    --         require("coq").setup({})
    --     end,
    -- },

    -- {
    --     "ms-jpq/coq.artifacts",
    --     enabled = false,
    --     branch = "artifacts"
    -- },

    -- {
    --     "ms-jpq/coq.thirdparty",
    --     enabled = false,
    --     branch = "3p"
    -- }
}
-- local lsp_servers = {
--     -- awk_ls = {}, -- AWK
--     -- angularls = {}, -- Angular
--     -- ansiblels = {}, -- Ansible
--     -- arduino_language_server = {}, -- Arduino
--     -- asm_lsp = {}, -- Assembly (GAS/NASM, GO)
--     -- spectral = {}, -- AsyncAPI
--     "bashls", -- Bash
--     -- beancount = {}, -- Beancount
--     -- bicep = {}, -- Bicep
--     -- ccls = {}, -- C
--     "clangd", -- C, C++
--     -- csharp_ls = {}, -- C#
--     -- omnisharp = {}, -- C#
--     -- ccls = {}, -- C++
--     "cmake",         -- CMake
--     "cssls",         -- CSS
--     "cssmodules_ls", -- CSS
--     -- clojure_lsp = {}, -- Clojure
--     -- codeqlls = {}, -- CodeQL
--     -- crystalline = {}, -- Crystal
--     -- scry = {}, -- Crystal
--     -- cucumber_language_server = {}, -- Cucumber
--     -- dartls = {}, -- Dart
--     -- denols = {}, -- Deno
--     -- diagnosticls = {}, -- Diagnostic (general purpose server)
--     -- serve_d = {}, -- Dlang
--     "dockerls", -- Docker
--     -- dotls = {}, -- Dot
--     -- efm = {}, -- EFM (general purpose server)
--     "eslint", -- ESLint
--     -- elixirls = {}, -- Elixir
--     -- elmls = {}, -- Elm
--     -- ember = {}, -- Ember
--     "emmet_ls", -- Emmet
--     -- erg_language_server = {}, -- Erg
--     -- erlangls = {}, -- Erlang
--     -- fsautocomplete = {}, -- F#
--     -- flux_lsp = {}, -- Flux
--     -- foam_ls = {}, -- Foam (OpenFOAM)
--     -- fortls = {}, -- Fortran
--     -- golangci_lint_ls = {}, -- Go
--     -- gopls = {}, -- Go
--     -- grammarly = {}, -- Grammarly
--     "graphql",  -- GraphQL
--     -- groovyls = {}, -- Groovy
--     "html",     -- HTML
--     -- hls = {}, -- Haskell
--     "jsonls ",  -- JSON
--     "jdtls  ",  -- Java
--     -- quick_lint_js = {}, -- JavaScript
--     "tsserver", -- TypeScript
--     -- jsonnet_ls = {}, -- Jsonnet
--     -- julials = {}, -- Julia
--     -- kotlin_language_server = {}, -- Kotlin
--     -- ltex = {}, -- LaTeX
--     "texlab", -- LaTeX
--     -- lelwel_ls = {}, -- Lelwel
--     "lua_ls", -- Lua
--     -- sumneko_lua = {}, -- Lua
--     -- remark_ls = {}, -- Markdown
--     -- zeta_note = {}, -- Markdown
--     -- zk = {}, -- Markdown
--     -- nickel_ls = {}, -- Nickel
--     -- nimls = {}, -- Nim
--     -- ocamlls = {}, -- OCaml
--     -- ccls = {}, -- Objective C
--     -- bsl_ls = {}, -- OneScript, 1C:Enterprise
--     -- spectral = {}, -- OpenAPI
--     -- opencl_ls = {}, -- OpenCL
--     -- intelephense = {}, -- PHP
--     -- phpactor = {}, -- PHP
--     -- psalm = {}, -- PHP
--     "powershell_es", -- Powershell
--     -- prismals = {},      -- Prisma
--     -- puppet = {}, -- Puppet
--     -- purescriptls = {}, -- PureScript
--     -- jedi_language_server = {}, -- Python
--     "pyright", -- Python
--     pylsp = {
--         settings = {
--             pylsp = {
--                 plugins = {
--                     pycodestyle = { maxLineLength = 120 },
--                     pyflakes = { enabled = false },
--                 },
--             },
--         },
--     }, -- Python
--     -- rescriptls = {}, -- ReScript
--     -- rome = {}, -- Rome
--     -- solargraph = {}, -- Ruby
--     "rust_analyzer", -- Rust
--     "sqlls",         -- SQL
--     -- sqls = {}, -- SQL
--     -- salt_ls = {}, -- Salt
--     -- theme_check = {}, -- Shopify Theme Check
--     -- solang = {}, -- Solidity
--     -- solc = {}, -- Solidity
--     -- solidity_ls = {}, -- Solidity (VSCode)
--     -- sorbet = {}, -- Sorbet
--     -- esbonio = {}, -- Sphinx
--     -- stylelint_lsp = {}, -- Stylelint
--     -- svelte = {}, -- Svelte
--     -- sourcekit = {}, -- Swift
--     -- verible = {}, -- SystemVerilog
--     -- taplo = {},       -- TOML
--     -- tailwindcss = {}, -- Tailwind CSS
--     "terraformls", -- Terraform
--     -- tflint = {}, -- Terraform
--     -- vala_ls = {}, -- Vala
--     "vimls", -- VimL
--     -- volar = {}, -- Vue
--     -- vuels = {
--     --     -- https://stackoverflow.com/questions/65913547/ionic-slot-attributes-are-deprecated-eslint-plugin-vue
--     --     init_options = { config = { vetur = { validation = { template = false } } } },
--     -- }, -- Vue
--     -- lemminx = {}, -- XML
--     "yamlls" -- YAML
--     -- zls = {}, -- Zig
-- }
