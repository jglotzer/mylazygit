require("config.lazy")
require("config.sets")
-- Seems like some things have to be done as config and not as plugins.
require("config.lualine")
require("config.yankstack")
require("vim.highlight").on_yank({ timeout = 100 })

-- Some things have to be done later.
local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>tf', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>ta', telescope_builtin.live_grep, {})
