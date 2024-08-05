return {

  {
    "rcarriga/nvim-notify",

    opts = {
      timeout = 0
    }
  },

  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    enabled = function()
      if vim.g.neovide or vim.g.vscode then
        return false
      end

      return true
    end,

    opts = function(_, opts)
      opts.scroll = {
        enabled = false
      }
    end
  },

  {
    "karb94/neoscroll.nvim",

    config = function()
      -- local keymaps = { "<C-u>", "<C-d>", "zt", "zz", "zb" }

      require("neoscroll").setup({
        hide_cursor = false,
        stop_eof = true,              -- Stop at <EOF> when scrolling downwards
        respect_scrolloff = true,     -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = false, -- The cursor will keep on scrolling even if the window cannot scroll further
        -- easing_function = nil, -- Default easing function
        -- pre_hook = nil,  -- Function to run before the scrolling animation starts
        -- post_hook = nil, -- Function to run after the scrolling animation ends
        -- performance_mode = false, -- Disable "Performance Mode" on all buffers.
      })
    end
  }
}
