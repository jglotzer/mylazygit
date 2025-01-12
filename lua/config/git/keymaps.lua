-- https://www.linkedin.com/pulse/mastering-three-way-merge-neovim-fugitive-delta-joey-wang-ldtfc/
-- Keymaps for Git operations
vim.keymap.set('n', '<leader>gs', ':Git<CR>', { desc = 'Git status' })
vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit<CR>', { desc = 'Git vdiff split' })
vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = 'Git Commit' })
vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { desc = 'Git Blame' })
vim.keymap.set('n', '<leader>gm', ':Git mergetool<CR>', { desc = 'Git Merge' })

-- Improve diff experience
vim.opt.diffopt:append('algorithm:patience')
vim.opt.diffopt:append('indent-heuristic')

-- Conflict resolution
vim.keymap.set('n', '<leader>m1', ':diffget 1<CR>', { desc = 'merge from left buffer' })
vim.keymap.set('n', '<leader>m2', ':diffget 2<CR>', { desc = 'merge from right buffer' })
vim.keymap.set('n', '<leader>mp', ':diffput 3<CR>', { desc = 'merge from this buffer' })

-- Show conflict stats
-- Not super interesting
vim.cmd([[
function! ConflictStats()
    let l:conflict_pattern = '^<<<<<<< '
    let l:conflicts = search(l:conflict_pattern, 'n')
    echo "Remaining conflicts: " . l:conflicts
endfunction
]])
vim.keymap.set('n', '<leader>zz', ':call ConflictStats()<CR>')
