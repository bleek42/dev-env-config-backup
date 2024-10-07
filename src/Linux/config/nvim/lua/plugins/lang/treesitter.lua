return {

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = { "p00f/nvim-ts-rainbow" },
        lazy = false,
        priority = 1000,

        opts = function(_, opts)
            if vim.loop.os_uname().sysname:lower():match("windows") then
                require("nvim-treesitter.install").prefer_git = false
            else
                require("nvim-treesitter.install").prefer_git = true
            end

            opts.sync_install = false --? install languages synchronously (only applied to
            opts.ensure_installed = {
                -- "astro",
                "bash",
                -- "beancount",
                -- "bibtex",
                "c",
                -- "c_sharp",
                -- "clojure",
                "cmake",
                -- "comment",
                -- "commonlisp",
                -- "cooklang",
                -- "cpp",
                "css",
                -- "cuda",
                -- "d",
                -- "dart",
                -- "devicetree",
                "dockerfile",
                -- "dot",
                -- "eex",
                -- "elixir",
                -- "elm",
                -- "elvish",
                -- "embedded_template",
                -- "erlang",
                -- "fennel",
                "fish",
                -- "foam",
                -- "fortran",**
                -- "fusion",
                -- "Godot",
                -- "gleam",
                -- "Glimmer",
                -- "glsl",
                -- "go",
                -- "gomod",
                -- "gowork",
                "graphql",
                -- "hack",
                -- "haskell",
                -- "hcl",
                -- "heex",
                -- "help",
                -- "hjson",
                -- "hocon",
                "html",
                "http",
                -- "java",
                "javascript",
                "jsdoc",
                -- "json",
                "json5",
                "jsonc",
                -- "julia",
                -- "kotlin",
                -- "lalrpop",
                "latex",
                -- "ledger",
                -- "llvm",
                "lua",
                -- "m68k",
                "make",
                "markdown",
                -- "ninja",
                "nix",
                -- "norg",
                -- "ocaml",
                -- "ocaml_interface",
                -- "ocamllex",
                -- "org",
                -- "pascal",
                -- "perl",
                -- "php",
                -- "phpdoc",
                -- "pioasm",
                "prisma",
                "proto",
                -- "pug",
                "python",
                -- "ql",
                -- "r",
                -- "rasi",
                "regex",
                -- "rego",
                -- "rst",
                -- "ruby",
                "rust",
                -- "scala",
                "scheme",
                "scss",
                -- "slint",
                "solidity",
                -- "sparql",
                -- "supercollider",
                -- "surface",
                -- "svelte",
                -- "swift",
                -- "teal",
                -- "tlaplus",
                -- "todotxt",
                "toml",
                "tsx",
                -- "turtle",
                "typescript",
                -- "vala",
                -- "verilog",
                -- "vim",
                -- "vue",
                -- "wgsl",
                "yaml",
                -- "yang",
                -- "zig",
            }


            opts.autopairs = {
                enable = true,
            }

            opts.highlight = {
                enable = true
            }

            opts.indent = {
                enable = true
            }

            opts.incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                }
            }

            opts.context_commentstring = {
                enable = true,
                enable_autocmd = false,
            }

            opts.textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                    },
                },

                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>ma"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<leader>Ma"] = "@parameter.inner",
                    },
                },

                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]]"] = "@class.outer",
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]["] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[["] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[]"] = "@class.outer",
                    },
                },
            }

            opts.matchup = {
                enable = true,
                disable_virtual_text = false,
                include_match_words = true,
            }
            -- third party
            opts.rainbow = {
                enabled = true
            }
            return opts
        end,
    },

}
