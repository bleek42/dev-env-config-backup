return {

  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "arkav/lualine-lsp-progress",
    },

    config = function(plugin)
      local tab_max_length = 24

      if plugin.override then
        require("lazyvim.util").deprecate("lualine.override", "lualine.opts")
      end

      require("lualine").setup({
        extensions = {},
        options = {
          -- theme = "",
          component_separators = {
            left = "",
            right = ""
          },
          disabled_filetypes = { "toggleterm", "terminal" },
          section_separators = {
            left = "",
            right = ""
          }
        },
        sections = {
          lualine_b = { "branch", {
            "diff",
            symbols = {
              added = "󰐖 ",
              modified = "󱗜 ",
              removed = "󰍵 "
            }
          } },
          lualine_c = {
            "filename", {
            "diagnostics",
            sources = { "nvim_diagnostic" }
          },
            "lsp_progress"
          }
        },
        tabline = {
          lualine_a = {
            {
              "tabs",
              max_length = vim.o.columns,
              mode = 2,
              fmt = function(name)
                name = string.sub(name, 1, tab_max_length)

                local padding = tab_max_length - #name
                local pad_left = math.floor(padding / 2)
                local pad_right = math.ceil(padding / 2)

                return string.rep(" ", pad_left) .. name .. string.rep(" ", pad_right)
              end
            }
          }
        }
      })
    end
  }
}
