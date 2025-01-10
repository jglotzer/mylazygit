vim.api.nvim_create_user_command(
  "StripTrailingWS",
  function()
    local cursor_pos = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", cursor_pos)
  end,
  { bang = true, desc = "Strip Trailing Whitespace" }
)

vim.api.nvim_create_user_command(
  "BegoneEmptyLines",
  function()
    vim.cmd([[g/^$/de]])
  end,
  { bang = true, desc = "Begone Empty Lines" }
)

-- Kind of weak to use vimscript but anyway ...
-- diffoff to get out
-- extra flourish swap buffers at end so saved version is on left.
-- https://unix.stackexchange.com/questions/46827/vim-executing-a-key-command-in-a-function
-- Other options is normal 
-- or call feedkeys()
-- where above is gotten by typing ctrl-v ctrl-c then ctrl-v ctrl-r
vim.cmd [[
function! s:DiffWithSaved()
  let myfiletype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . myfiletype
  exe "normal \<C-W>\<C-R>"
endfunction
com! DiffSaved call s:DiffWithSaved()
]]
