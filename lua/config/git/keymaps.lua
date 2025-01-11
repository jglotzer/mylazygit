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

-- Quick conflict resolution
vim.keymap.set('n', '<leader>gf', ':diffget 1<CR>')  -- get from left
vim.keymap.set('n', '<leader>gj', ':diffget 2<CR>')  -- get from right

-- Show conflict stats
vim.cmd([[
function! ConflictStats()
    let l:conflict_pattern = '^<<<<<<< '
    let l:conflicts = search(l:conflict_pattern, 'n')
    echo "Remaining conflicts: " . l:conflicts
endfunction
]])
vim.keymap.set('n', '<leader>gc', ':call ConflictStats()<CR>')
