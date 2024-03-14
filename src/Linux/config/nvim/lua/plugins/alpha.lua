return {
	{
		"goolord/alpha-nvim",
		opts = function(_, opts)
			opts.section.header.val = {
				[[]],
				[[=================     ===============     ===============   ========  ========]],
				[[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
				[[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
				[[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
				[[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
				[[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
				[[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
				[[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
				[[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
				[[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
				[[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
				[[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
				[[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
				[[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
				[[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
				[[||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
				[[||.=='    _-'                                                     `' |  /==.||]],
				[[=='    _-'                        N E O V I M                         \/   `==]],
				[[\   _-'                                                                `-_   /]],
				[[ `''                                                                      ``']]
			}

			return opts
		end
	},

	"catppuccin/nvim",
	name = "catppuccin",
	opts = {
		dim_inactive = { enabled = true, percentage = 0.25 },
		integrations = {
			alpha = false,
			dashboard = false,
			flash = false,
			nvimtree = false,
			ts_rainbow = false,
			ts_rainbow2 = false,
			barbecue = false,
			indent_blankline = false,
			navic = false,
			dropbar = false,

			aerial = true,
			dap = { enabled = true, enable_ui = true },
			headlines = true,
			mason = true,
			native_lsp = { enabled = true, inlay_hints = { background = false } },
			neogit = true,
			neotree = true,
			noice = true,
			notify = true,
			sandwich = true,
			semantic_tokens = true,
			symbols_outline = true,
			telescope = { enabled = true, style = "nvchad" },
			which_key = true,
		},
		custom_highlights = {
			-- disable italics  for treesitter highlights
			TabLineFill = { link = "StatusLine" },
			LspInlayHint = { style = { "italic" } },
			["@parameter"] = { style = {} },
			["@type.builtin"] = { style = {} },
			["@namespace"] = { style = {} },
			["@text.uri"] = { style = { "underline" } },
			["@tag.attribute"] = { style = {} },
			["@tag.attribute.tsx"] = { style = {} },
		},
	},
}

-- You can disable default plugins as follows:
-- { "max397574/better-escape.nvim", enabled = false },
--
-- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
-- {
--   "L3MON4D3/LuaSnip",
--   config = function(plugin, opts)
--     require "plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
--     -- add more custom luasnip configuration such as filetype extend or custom snippets
--     local luasnip = require "luasnip"
--     luasnip.filetype_extend("javascript", { "javascriptreact" })
--   end,
-- },
-- {
--   "windwp/nvim-autopairs",
--   config = function(plugin, opts)
--     require "plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
--     -- add more custom autopairs configuration such as custom rules
--     local npairs = require "nvim-autopairs"
--     local Rule = require "nvim-autopairs.rule"
--     local cond = require "nvim-autopairs.conds"
--     npairs.add_rules(
--       {
--         Rule("$", "$", { "tex", "latex" })
--           -- don't add a pair if the next character is %
--           :with_pair(cond.not_after_regex "%%")
--           -- don't add a pair if  the previous character is xxx
--           :with_pair(
--             cond.not_before_regex("xxx", 3)
--           )
--           -- don't move right when repeat character
--           :with_move(cond.none())
--           -- don't delete if the next character is xx
--           :with_del(cond.not_after_regex "xx")
--           -- disable adding a newline when you press <cr>
--           :with_cr(cond.none()),
--       },
--       -- disable for .vim files, but it work for another filetypes
--       Rule("a", "a", "-vim")
--     )
--   end,
-- },
-- By adding to the which-key config and using our helper function you can add more which-key registered bindings
-- {
--   "folke/which-key.nvim",
--   config = function(plugin, opts)
--     require "plugins.configs.which-key"(plugin, opts) -- include the default astronvim config that calls the setup call
--     -- Add bindings which show up as group name
--     local wk = require "which-key"
--     wk.register({
--       b = { name = "Buffer" },
--     }, { mode = "n", prefix = "<leader>" })
--   end,
-- },
-- }
