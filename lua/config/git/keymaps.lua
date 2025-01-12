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

local bufopts = { noremap = true, silent = true }
-- Conflict resolution
vim.keymap.set('n', '<leader>d1', ':diffget 1 <CR>',
  vim.tbl_deep_extend("error", bufopts, { desc = 'Diffget from left buffer' }))
vim.keymap.set('n', '<leader>d2', ':diffget 2 <CR>',
  vim.tbl_deep_extend("error", bufopts, { desc = 'Diffget from right buffer' }))
vim.keymap.set('n', '<leader>dp', ':diffput 3 <CR>',
  vim.tbl_deep_extend("error", bufopts, { desc = 'Diffput from this buffer' }))

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
