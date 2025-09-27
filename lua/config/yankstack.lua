vim.cmd([[
  call yankstack#setup()
  nmap Y y$
  nmap <C-p> <Plug>yankstack_substitute_older_paste
  nmap <C-n> <Plug>yankstack_substitute_newer_paste
  let g:yankstack_yank_keys = ['c', 'C', 'd', 'D', 's', 'S', 'x', 'X', 'y', 'Y']
]])

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  desc = "Highlight selection on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
  end,
})
