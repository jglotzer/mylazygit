-- https://www.reddit.com/r/neovim/comments/16qls9t/what_value_do_you_set_for_listchars/
-- Getting this right was way harder it should have been.
-- Ideally could directly just set
-- vim.opt.listchars.trail without using a table but that sadly doesn't work.
-- Also when debugging could not do any print on InsertEnter but clearly that
-- event *was* firing.
-- But this code does the needful.
-- Also doesn't mess up the Terminal, so it's all good.
vim.opt.list = true
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.opt.listchars = {
      tab = "> ",
      trail = nil,
      nbsp = "+"
    }
  end
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.opt.listchars = {
      tab = "> ",
      trail = '-',
      nbsp = "+"
    }
  end
})
