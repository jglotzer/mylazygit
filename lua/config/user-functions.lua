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
