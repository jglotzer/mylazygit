
vim.cmd [[
  call yankstack#setup()
  nmap Y y$
  nmap <C-p> <Plug>yankstack_substitute_older_paste
  nmap <C-n> <Plug>yankstack_substitute_newer_paste
  let g:yankstack_yank_keys = ['c', 'C', 'd', 'D', 's', 'S', 'x', 'X', 'y', 'Y']

]]

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 100 }
  end,
})

  -- augroup highlight_yank
  --   autocmd!
  --   autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 100})
  -- augroup END
