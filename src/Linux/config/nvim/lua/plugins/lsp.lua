return {

	{
		"jose-elias-alvarez/typescript.nvim",
		init = function()
			table.insert(astronvim.lsp.skip_setup, "tsserver")
		end,
		ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
		opts = function()
			return { server = require("astronvim.utils.lsp").config "tsserver" }
		end
	},

	{
		"p00f/clangd_extensions.nvim",

		ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
		opts = function()
			return {
				server = require("utils.lsp").config("clangd"),
				extensions = { autoSetHints = false }
			}
		end
	},

	{
		"onsails/lspkind.nvim",
		opts = function(_, opts)
			-- use codicons preset
			opts.preset = "codicons"
			-- set some missing symbol types
			opts.symbol_map = {
				Array = "",
				Boolean = "",
				Key = "",
				Namespace = "",
				Null = "",
				Number = "",
				Object = "",
				Package = "",
				String = ""
			}
			return opts
		end

	}

}
