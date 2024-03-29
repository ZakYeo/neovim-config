if vim.loader and vim.fn.has "nvim-0.9.1" == 1 then vim.loader.enable() end

for _, source in ipairs {
  "astronvim.bootstrap",
  "astronvim.options",
  "astronvim.lazy",
  "astronvim.autocmds",
  "astronvim.mappings",
} do
  local status_ok, fault = pcall(require, source)
  if not status_ok then vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault) end
end

if astronvim.default_colorscheme then
  if not pcall(vim.cmd.colorscheme, astronvim.default_colorscheme) then
    require("astronvim.utils").notify(
      ("Error setting up colorscheme: `%s`"):format(astronvim.default_colorscheme),
      vim.log.levels.ERROR
    )
  end
end

require("astronvim.utils").conditional_func(astronvim.user_opts("polish", nil, false), true)

require('telescope').setup {
  defaults = {
    file_ignore_patterns = {"node_modules"},
    layout_config = {
      horizontal = {
        preview_cutoff = 0,
      },
    },
  }
}

-- Enable true color support
if vim.fn.has("termguicolors") == 1 then
  vim.o.termguicolors = true
end

vim.opt.termguicolors = true
-- Transparency settings
local transparency_settings = {
  Normal = { bg = "NONE" },
  NormalNC = { bg = "NONE" },
  CursorColumn = { bg = "NONE" },
  CursorLine = { bg = "NONE" },
  CursorLineNr = { bg = "NONE" },
  LineNr = { bg = "NONE" },
  SignColumn = { bg = "NONE" },
  StatusLine = { bg = "NONE" },
  NeoTreeNormal = { bg = "NONE" },
  NeoTreeNormalNC = { bg = "NONE" },
}

for group, settings in pairs(transparency_settings) do
  vim.api.nvim_set_hl(0, group, settings)
end

-- Automatically enter insert mode when opening a terminal
vim.cmd [[
  autocmd TermOpen * startinsert
]]

-- CTRL+O to exit input mode in :term
vim.api.nvim_set_keymap('t', '<C-o>', [[<C-\><C-n>]], {noremap = true, silent = true})


-- C+d & C+u will auto center
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', {noremap = true, silent = true})

-- Using n or N will auto center
vim.api.nvim_set_keymap('n', 'n', 'nzz', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'N', 'Nzz', {noremap = true, silent = true})



