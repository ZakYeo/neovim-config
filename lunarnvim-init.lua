
lvim.transparent_window = true
lvim.builtin.lualine.style = "default" -- or "none"
lvim.builtin.nvimtree.active = false   -- NOTE: using neo-tree

-- Unbind 'Space+f' in Normal mode
lvim.builtin.which_key.mappings['f'] = {}
lvim.builtin.which_key.mappings['e'] = {}
-- Auto command to enable word wrap for Markdown files only
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.wrap = true  -- Enable word wrap
        vim.opt_local.linebreak = true  -- Wrap lines at word boundaries
    end,
})

lvim.plugins = {
{ "savq/melange-nvim"},
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        window = {
          position = "right",
          width = 30,
        },
        mappings = {
          ["<leader>e"] = function()
            vim.cmd("q")
          end,
        },
        buffers = {
          follow_current_file = true,
        },
        filesystem = {
          follow_current_file = true,
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
      })
    end
  },
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      require("gitblame").setup { 
        enabled = true,
        delay = 5000
      }
    end,
  },

  --[[Looks ugly -> {
    "hiphish/rainbow-delimiters.nvim",
  },--]]
  {
    "karb94/neoscroll.nvim",
    config = function()
      local neoscroll = require('neoscroll')
      neoscroll.setup({
        easing = "quadratic"
      })
    end,
  },

}


lvim.colorscheme="melange"

lvim.builtin.treesitter.highlight.enabled = true

-- Navigate between buffers with [b and ]b
lvim.keys.normal_mode["]b"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["[b"] = ":BufferLineCyclePrev<CR>"
lvim.format_on_save.enabled = false

lvim.builtin.cmp.enabled = true
-- Import which-key register function
local wk = require("which-key")
-- Setup leader+f mappings
-- I prefer leader+ff for find files & leader+fw for find word
wk.register({
  f = {
    name = "Find",
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    w = { "<cmd>Telescope live_grep<cr>", "Find Word" },
    o = { "<cmd>Telescope oldfiles<cr>", "Recently Opened Files" }
  }
}, { prefix = "<leader>" })
wk.register({
  e = { "<cmd>Neotree toggle<CR>", "Toggle Neotree" }
})

-- Import Telescope and set up the configuration
local actions = require("telescope.actions")
local telescope = require("telescope")

telescope.setup {
  defaults = {
    -- Default configuration for Telescope
    -- Configure the layout to make preview appear on the right
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55, -- Adjust the width of the preview as needed
      },
      width = 0.95,           -- Adjust the overall width of the Telescope window
      height = 0.85,          -- Adjust the overall height of the Telescope window
      preview_cutoff = 120,   -- Minimum width of Telescope window to show preview
    },
    layout_strategy = "horizontal",
  },
}
