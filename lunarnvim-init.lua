-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--
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
    vim.opt_local.wrap = true      -- Enable word wrap
    vim.opt_local.linebreak = true -- Wrap lines at word boundaries
  end,
})

lvim.plugins = {
  { "savq/melange-nvim" },
  { "catppuccin/nvim" },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          enable_close = true,          -- Auto close tags
          enable_rename = true,         -- Auto rename pairs of tags
          enable_close_on_slash = false -- Auto close on trailing </
        },
      })
    end
  },
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
        -- Default easing function used in any animation where
        -- the `easing` argument has not been explicitly supplied
        easing = "quadratic"
      })
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        --open_mapping = [[<leader>t]],
        size = function(term)
          if term.direction == "horizontal" then
            return 25
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          else
            return 20
          end
        end,
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = false,
        insert_mappings = true,
        persist_size = true,
        direction = 'float',
        close_on_exit = false,
        float_opts = {
          border = 'curved',
          winblend = 0,
        },
        on_open = function(term)
          local opts = { buffer = 0 }
          vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts)
          vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts) -- Exit insert mode in terminal using 'jk'
          vim.keymap.set('t', '<C-w>]', '<cmd>close<CR>', opts)
        end
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup {
        defaults = {
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
            },
            width = 0.95,
            height = 0.85,
            preview_cutoff = 120,
          },
          layout_strategy = "horizontal",
        },
      }
    end
  },


}

lvim.colorscheme = "melange"

lvim.builtin.treesitter.highlight.enabled = true

-- Navigate between buffers with [b and ]b
lvim.keys.normal_mode["]b"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["[b"] = ":BufferLineCyclePrev<CR>"
lvim.format_on_save.enabled = true

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
  },
  t = {
    name = "Terminal", -- Group name for all terminal related keybindings
    t = { "<cmd>ToggleTerm<cr>", "Toggle Floating Terminal" },
    h = { "<cmd>ToggleTerm direction=horizontal<cr>", "Horizontal Split Terminal" },
    v = { "<cmd>ToggleTerm direction=vertical<cr>", "Vertical Split Terminal" },
  },
}, { prefix = "<leader>" })
wk.register({
  e = { "<cmd>Neotree toggle<CR>", "Toggle Neotree" }
})
