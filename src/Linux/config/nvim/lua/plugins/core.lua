return {
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"907th/vim-auto-save",
		config = function()
			vim.g.auto_save = 1
		end,

	},
	{ "max397574/better-escape.nvim",        enabled = false },
	{ "lukas-reineke/indent-blankline.nvim", enabled = false },

	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{ "theHamsta/nvim-dap-virtual-text", config = true },
		}
	},
	{
		"akinsho/toggleterm.nvim",
		opts = {
			terminal_mappings = false,
		}
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 0,
		}
	},
	{
		"mrjones2014/smart-splits.nvim",
		build = "./kitty/install-kittens.bash",
		opts = function(_, opts) opts.at_edge = require("smart-splits.types").AtEdgeBehavior.stop end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signcolumn = false,
			numhl = true,
			current_line_blame_opts = { ignore_whitespace = true },
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			filesystem = {
				hijack_netrw_behavior = "open_default",
				filtered_items = {
					always_show = { ".github", ".gitignore" },
				},
			},
		},
	},
	{
		"aserowy/tmux.nvim",
		config = function()
			require("tmux").setup({
				copy_sync = {
					enable = true,
					redirect_to_clipboard = true,
				},
				navigation = {
					cycle_navigation = false,
					enable_default_keybindings = true,
					persist_zoom = true,
				},
				resize = {
					enable_default_keybindings = true,
				},
			})
		end,
	},
	{
		"luukvbaal/nnn.nvim",
		config = function()
			local builtin = require("nnn").builtin

			require("nnn").setup(
				{
					explorer = {
						width = 24, -- width of the vertical split
						side = "topleft", -- or "botright", location of the explorer window
						session = "shared", -- or "global" / "local" / "shared"
						tabs = true, -- separate nnn instance per tab
						fullscreen = true -- whether to fullscreen explorer window when current tab is empty
					},
					picker = {
						cmd = "nnn",          -- command override (-p flag is implied)
						style = {
							width = 0.9,      -- percentage relative to terminal size when < 1, absolute otherwise
							height = 0.8,     -- ^
							xoffset = 0.5,    -- ^
							yoffset = 0.5,    -- ^
							border = "single" -- border decoration for example "rounded"(:h nvim_open_win)
						},
						session = "local",    -- or "global" / "local" / "shared"
						tabs = true,          -- separate nnn instance per tab
						fullscreen = true     -- whether to fullscreen picker window when current tab is empty
					},
					auto_close = false,       -- close tabpage/nvim when nnn is last window
					replace_netrw = "picker", -- or "explorer" / "picker"
					mappings = {
						{ "<C-t>", builtin.open_in_tab }, -- open file(s) in tab
						{ "<C-s>", builtin.open_in_split }, -- open file(s) in split
						{ "<C-v>", builtin.open_in_vsplit }, -- open file(s) in vertical split
						{ "<C-p>", builtin.open_in_preview }, -- open file in preview split keeping nnn focused
						{ "<C-y>", builtin.copy_to_clipboard }, -- copy file(s) to clipboard
						{ "<C-w>", builtin.cd_to_path }, -- cd to file directory
						{ "<C-e>", builtin.populate_cmdline } -- populate cmdline (:) with file(s)
					},                        -- table containing mappings, see below
					windownav = {
						-- window movement mappings to navigate out of nnn
						left = "<C-w>h",
						right = "<C-w>l",
						next = "<C-w>w",
						prev = "<C-w>W"
					},
					buflisted = false, -- whether or not nnn buffers show up in the bufferlist
					quitcd = nil, -- or "cd" / tcd" / "lcd", command to run on quitcd file if found
					offset = false -- whether or not to write position offset to tmpfile(for use in preview-tui)
				}
			)
		end,

		dependencies = { "nvim-tree/nvim-web-devicons" }
	},
}
