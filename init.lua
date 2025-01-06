require("config.lazy")
require("config.sets")
-- Seems like some things have to be done as config and not as plugins.
require("config.lualine")
require("config.yankstack")
require'vim.highlight'.on_yank({timeout = 100})
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd.colorscheme "catppuccin"

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>tf', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>ta', telescope_builtin.live_grep, {})

