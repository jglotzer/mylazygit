-- https://www.linkedin.com/pulse/mastering-three-way-merge-neovim-fugitive-delta-joey-wang-ldtfc/
-- Helpful keymaps for Git operations
vim.keymap.set('n', '<leader>gs', ':Git<CR>')
vim.keymap.set('n', '<leader>gd', ':Gdiffsplit<CR>')
vim.keymap.set('n', '<leader>gc', ':Git commit<CR>')
vim.keymap.set('n', '<leader>gb', ':Git blame<CR>')
vim.keymap.set('n', '<leader>gm', ':Git mergetool<CR>')

-- Improve diff experience
vim.opt.diffopt:append('algorithm:patience')
vim.opt.diffopt:append('indent-heuristic')
