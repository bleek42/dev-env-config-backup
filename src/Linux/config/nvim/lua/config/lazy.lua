local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
        lazypath })
end

vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local opts = {}

if vim.loop.os_uname().version:match("Windows") then
    opts.concurrency = 1
end

if vim.g.vscode then
    -- local vscode = require("plugins.vscode")

    opts.root = vim.fn.stdpath("data") .. "/lazy-vscode"
    opts.lockfile = vim.fn.stdpath("config") .. "/lazy-vscode-lock.json"

    require("lazy").setup({
        spec = {
            {
                "LazyVim/LazyVim",
                import = "lazyvim.plugins",
                opts = opts
            },

            {
                import = "lazyvim.plugins.extras.vscode"
            },

            {
                import = "plugins.editor.vscode"
            },

            {
                import = "plugins.editor.telescope",
            },

        },
        performance = {
            rtp = {
                -- disable some rtp plugins
                disabled_plugins = {
                    "gzip",
                    "matchit",
                    "matchparen",
                    "netrwPlugin",
                    "tarPlugin",
                    "tohtml",
                    "zipPlugin",
                    "tutor"
                }
            }
        }
    })
else
    --   opts.colorscheme = "hardhacker"

    require("lazy").setup({
        spec = {
            -- add LazyVim and import its plugins
            {
                "LazyVim/LazyVim",
                import = "lazyvim.plugins",
                opts = opts
            }, -- lazyvim plugins

            -- extras
            {
                import = "lazyvim.plugins.extras.linting.eslint"
            },
            {
                import = "lazyvim.plugins.extras.formatting.prettier"
            },

            {
                import = "lazyvim.plugins.extras.ui.mini-animate"
            },

            {
                import = "lazyvim.plugins.extras.ui.edgy"
            },

            -- coding
            {
                import = "lazyvim.plugins.extras.coding.yanky"
            },


            -- editor
            {
                import = "lazyvim.plugins.extras.editor.aerial"
            },

            -- -- lang
            -- {
            --     import = "lazyvim.plugins.extras.lang.typescript"
            -- },
            {
                import = "lazyvim.plugins.extras.lang.json"
            },
            {
                import = "lazyvim.plugins.extras.lang.docker"
            },
            {
                import = "lazyvim.plugins.extras.lang.python"
            },
            {
                import = "lazyvim.plugins.extras.lang.yaml"
            },

            -- dap
            {
                import = "lazyvim.plugins.extras.dap.core"
            },

            {
                import = "lazyvim.plugins.extras.dap.nlua"
            },

            -- test / util
            {
                import = "lazyvim.plugins.extras.test.core"
            },

            {
                import = "lazyvim.plugins.extras.util.dot"
            },

            {
                import = "lazyvim.plugins.extras.util.mini-hipatterns"
            },

            -- import any custom plugins here
            {
                import = "plugins.themes"
            },

            {
                import = "plugins.ui"
            },

            {
                import = "plugins.lang"
            },

            {
                import = "plugins.editor"
            },

            {
                import = "plugins.term"
            }
        },

        defaults = {
            -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
            -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
            lazy = false,
            -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
            -- have outdated releases, which may break your Neovim install.
            version = false -- always use the latest git commit
            -- version = "*", -- try installing the latest stable version for plugins that support semver
        },
        install = {
            colorscheme = {
                "hardhacker",
                "monokai",
            },
        },
        checker = {
            -- automatically check for plugin updates
            enabled = true
        },
        performance = {
            rtp = {
                -- disable some rtp plugins

                disabled_plugins = {
                    "gzip",
                    "netrwPlugin",
                    "matchit",
                    "matchparen",
                    "tarPlugin",
                    "tohtml",
                    "zipPlugin"
                }
            }
        }
    })
end
