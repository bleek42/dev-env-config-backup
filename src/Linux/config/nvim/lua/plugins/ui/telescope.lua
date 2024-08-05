return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    event = "VeryLazy",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-dap.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "ThePrimeagen/harpoon",
    },

    config = function(_, opts)
      -- local themes = require("utils.themer")

      local actions = require("telescope.actions")
      local keymaps = {}
      keymaps.search = function(actions)
        return {
          ["<C-d>"] = actions.delete_buffer,
          ["<C-q>"] = actions.send_to_qflist
        }
      end

      require("telescope").setup({
        defaults = {
          extensions = {
            fzf = {
              fuzzy = true,
              override_generic_sorter = true,
              override_file_sorter = true,
              case_mode = "smart_case"
            },
            ["ui-select"] = { require("telescope.themes").get_dropdown({
              winblend = 10,
              border = true,
              previewer = false,
              layout_config = {
                height = 20,
                width = 0.5
              },
              borderchars = {
                prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
                results = { " " },
                preview = { "─", "─", " ", " ", "─", "─", " ", " " }
              }
            }) }
          },
          mappings = {
            i = keymaps.search(actions),
            n = keymaps.search(actions)
          },
          layout_strategy = "flex"
        }
      })

      require("telescope").load_extension("dap")
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("harpoon")
    end
  },

  {
    "joshmedeski/telescope-smart-goto.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "ThePrimeagen/harpoon"
    }
  },

}
