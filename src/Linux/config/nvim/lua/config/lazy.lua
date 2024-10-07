local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
        lazypath })
end

vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local opts = {}
local is_win = vim.uv.os_uname().sysname:find("Windows")
print(is_win)
if is_win then
    print("Is LazyVim in Windows")
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
                -- import = "plugins.editor.vscode"
            },

            {
                import = "plugins.lang.treesitter"
            }
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
    opts.colorscheme = function()
        vim.cmd("colorscheme cyberdream")
    end

    require("lazy").setup({
        spec = {
            -- add LazyVim and import its plugins
            {
                "LazyVim/LazyVim",
                import = "lazyvim.plugins",
                opts = opts
            },
            -- lazyvim plugins
            -- extras

            {
                import = "lazyvim.plugins.extras.ui.edgy"
            },

            {
                import = "lazyvim.plugins.extras.ui.mini-indentscope"
            },

            {
                import = "lazyvim.plugins.extras.ui.mini-animate"
            },

            {
                import = "lazyvim.plugins.extras.util.mini-hipatterns"
            },

            {
                import = "lazyvim.plugins.extras.ui.treesitter-context"
            },

            {
                import = "lazyvim.plugins.extras.editor.aerial"
            },

            {
                import = "lazyvim.plugins.extras.editor.dial"
            },

            {
                import = "lazyvim.plugins.extras.editor.leap"
            },

            {
                import = "lazyvim.plugins.extras.editor.outline"
            },

            {
                import = "lazyvim.plugins.extras.editor.fzf"
            },

            -- {
            --     import = "lazyvim.plugins.extras.editor.telescope"
            -- },

            {
                import = "lazyvim.plugins.extras.editor.illuminate"
            },

            {
                import = "lazyvim.plugins.extras.editor.navic"
            },

            {
                import = "lazyvim.plugins.extras.editor.outline"
            },

            {
                import = "lazyvim.plugins.extras.editor.refactoring"
            },

            {
                import = "lazyvim.plugins.extras.editor.overseer"
            },

            {
                import = "lazyvim.plugins.extras.editor.inc-rename"
            },

            {
                import = "lazyvim.plugins.extras.editor.mini-move"
            },

            {
                import = "lazyvim.plugins.extras.editor.mini-diff"
            },

            {
                import = "lazyvim.plugins.extras.editor.mini-files"
            },

            {
                import = "lazyvim.plugins.extras.coding.yanky"
            },

            {
                import = "lazyvim.plugins.extras.coding.luasnip"
            },

            {
                import = "lazyvim.plugins.extras.coding.neogen"
            },

            {
                import = "lazyvim.plugins.extras.coding.codeium"
            },

            {
                import = "lazyvim.plugins.extras.coding.mini-comment"
            },

            {
                import = "lazyvim.plugins.extras.coding.mini-surround"
            },

            {
                import = "lazyvim.plugins.extras.lsp"
            },

            {
                import = "lazyvim.plugins.extras.lang.json"
            },

            {
                import = "lazyvim.plugins.extras.lang.git"
            },

            {
                import = "lazyvim.plugins.extras.lang.markdown"
            },

            {
                import = "lazyvim.plugins.extras.lang.python"
            },

            {
                import = "lazyvim.plugins.extras.lang.docker"
            },

            {
                import = "lazyvim.plugins.extras.lang.rust"
            },

            {
                import = "lazyvim.plugins.extras.lang.sql"
            },

            {
                import = "lazyvim.plugins.extras.lang.nix"
            },

            {
                import = "lazyvim.plugins.extras.lang.nushell"
            },

            {
                import = "lazyvim.plugins.extras.lang.terraform"
            },

            {
                import = "lazyvim.plugins.extras.lang.yaml"
            },

            {
                import = "lazyvim.plugins.extras.lang.toml"
            },

            {
                import = "lazyvim.plugins.extras.linting.eslint"
            },

            {
                import = "lazyvim.plugins.extras.formatting.prettier"
            },

            {
                import = "lazyvim.plugins.extras.dap.core"
            },

            {
                import = "lazyvim.plugins.extras.dap.nlua"
            },
            -- test / util
            {
                import = "lazyvim.plugins.extras.util.dot"
            },

            {
                import = "lazyvim.plugins.extras.test.core"
            },

            {
                import = "lazyvim.plugins.extras.util.rest"
            },

            {
                import = "plugins.editor"
            },

            {
                import = "plugins.themes"
            },

            {
                import = "plugins.ui"
            },

            {
                import = "plugins.lang"
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
                "cyberdream"
            },
        },
        checker = {
            -- automatically check for plugin updates
            enabled = false
        },
        change_detection = {
            -- automatically check for config file changes and reload the ui
            enabled = true,
            notify = true, -- get a notification when changes are found
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
