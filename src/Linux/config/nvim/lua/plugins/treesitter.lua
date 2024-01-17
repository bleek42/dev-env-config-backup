return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", enabled = false },
		"nvim-telescope/telescope-live-grep-args.nvim",
		"nvim-telescope/telescope-hop.nvim",
		"nvim-telescope/telescope-bibtex.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		{
			"jay-babu/project.nvim",
			name = "project_nvim",
			event = "VeryLazy",
			opts = { ignore_lsp = { "lua_ls", "julials" } },
		},
	},
	opts = function(_, opts)
		local telescope = require "telescope"
		local actions = require "telescope.actions"
		local fb_actions = require("telescope").extensions.file_browser.actions
		local lga_actions = require "telescope-live-grep-args.actions"
		local hop = telescope.extensions.hop
		return require("astronvim.utils").extend_tbl(opts, {
			defaults = {
				results_title = "",
				selection_caret = "  ",
				layout_config = {
					width = 0.90,
					height = 0.85,
					preview_cutoff = 120,
					horizontal = {
						preview_width = 0.6,
					},
					vertical = {
						width = 0.9,
						height = 0.95,
						preview_height = 0.5,
					},
					flex = {
						horizontal = {
							preview_width = 0.9,
						},
					},
				},
				mappings = {
					i = {
						["<C-h>"] = hop.hop,
						["<C-space>"] = function(prompt_bufnr)
							hop._hop_loop(
								prompt_bufnr,
								{ callback = actions.toggle_selection, loop_callback = actions.send_selected_to_qflist }
							)
						end,
					},
				},
			},
			extensions = {
				bibtex = { context = true, context_fallback = false },
				file_browser = {
					mappings = {
						i = {
							["<C-z>"] = fb_actions.toggle_hidden,
						},
						n = {
							z = fb_actions.toggle_hidden,
						},
					},
				},
				live_grep_args = {
					auto_quoting = true, -- enable/disable auto-quoting
					mappings = { -- extend mappings
						i = {
							["<C-a>"] = lga_actions.quote_prompt(),
							["<C-f>"] = lga_actions.quote_prompt { postfix = " --iglob " },
						},
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					find_command = function(cfg)
						local find_command = { "rg", "--files", "--color", "never" }
						if not cfg.no_ignore then vim.list_extend(find_command, { "--glob", "!**/.git/**" }) end
						return find_command
					end,
				},
				buffers = {
					path_display = { "smart" },
					mappings = {
						i = { ["<c-d>"] = actions.delete_buffer },
						n = { ["d"] = actions.delete_buffer },
					},
				},
			},
		})
	end,
	config = function(...)
		require "plugins.configs.telescope" (...)
		local telescope = require "telescope"
		telescope.load_extension "live_grep_args"
		telescope.load_extension "bibtex"
		telescope.load_extension "file_browser"
		telescope.load_extension "projects"
	end,
}


-- dependencies = {
--     "p00f/nvim-ts-rainbow",
-- },
-- build = ":TSUpdate",
--     local ELLIPSIS_CHAR = "…"
--     local LABEL_WIDTH = 35

--     local cmp = require("cmp")
--     local handle = require("language.completion")
--     local lspkind = require("lspkind")

--     local options = require("nvim.options")
--     options.set(options.scope.option, "pumheight", 12)

--     cmp.setup({
--         completion = {
--             completeopt = "menu,menuone,noinsert",
--         },
--         formatting = {
--             format = lspkind.cmp_format({
--                 maxwidth = LABEL_WIDTH,
--                 mode = "symbol_text",
--                 symbol_map = { Copilot = "" },
--                 before = function(_, vim_item)
--                     local ellipsis_char_len = string.len(ELLIPSIS_CHAR)

--                     local label = vim_item.abbr
--                     if string.len(label) <= LABEL_WIDTH then
--                         local truncated_label = vim.fn.strcharpart(label, 0, LABEL_WIDTH - ellipsis_char_len)
--                         vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
--                     end

--                     local padding = string.rep(" ", LABEL_WIDTH - string.len(label))
--                     vim_item.abbr = label .. padding

--                     return vim_item
--                 end,
--             }),
--         },
--         mapping = require("mappings").editor_completion(cmp, handle),
--         snippet = {
--             expand = function(args)
--                 require("luasnip").lsp_expand(args.body)
--             end,
--         },
--         sources = {
--             { name = "copilot",  group_index = 2 },
--             { name = "luasnip",  group_index = 2 },
--             { name = "nvim_lsp", group_index = 2 },
--             { name = "nvim_lua", group_index = 2 },
--             { name = "path",     group_index = 2 },
--             { name = "buffer",   group_index = 2 },
--         },
--         window = {
--             completion = cmp.config.window.bordered(),
--             documentation = cmp.config.window.bordered()
--         },
--     })

--     cmp.setup.cmdline({ "/", "?" }, {
--         mapping = cmp.mapping.preset.cmdline(),
--         sources = {
--             { name = "buffer" },
--         },
--     })
-- end

-- local function setup_luasnip()
--     local luasnip = require("luasnip")

--     luasnip.config.set_config({
--         history = true,
--     })

--     require("luasnip/loaders/from_vscode").load()
-- end


--     {
--         "zbirenbaum/copilot.lua",
--         cmd = "Copilot",
--         event = "InsertEnter",
--         config = function()
--             require("copilot").setup({
--                 suggestion = { enabled = false },
--                 panel = { enabled = false },
--             })
--         end,
--     },
--     {
--         "zbirenbaum/copilot-cmp",
--         config = function()
--             require("copilot_cmp").setup()
--         end,
--     },


--     {
--         "hrsh7th/nvim-cmp",
--         config = function()
--             setup_cmp()
--         end,
--         dependencies = {
--             "hrsh7th/cmp-buffer",
--             "hrsh7th/cmp-nvim-lsp",
--             "hrsh7th/cmp-nvim-lua",
--             "hrsh7th/cmp-path",
--         },
--     },
--     "saadparwaiz1/cmp_luasnip",
--     {
--         "L3MON4D3/LuaSnip",
--         config = function()
--             setup_luasnip()
--         end,
--     },
--     "rafamadriz/friendly-snippets",
--     "onsails/lspkind-nvim",
-- }
