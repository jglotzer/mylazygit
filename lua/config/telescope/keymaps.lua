
local tbi = require('telescope.builtin')

vim.keymap.set("n", "<leader>ta", tbi.grep_string, { desc = "search current word" })
vim.keymap.set("n", "<leader>tg", tbi.live_grep, { desc = "live grep" })
vim.keymap.set("n", "<leader>tlg", tbi.live_grep, { desc = "live grep" })
vim.keymap.set("n", "<leader>tf", tbi.find_files, { desc = "find files" })
vim.keymap.set("n", "<leader>tb", tbi.buffers, { desc = "view buffers" })
vim.keymap.set("n", "<leader>th", tbi.help_tags, { desc = "view help tags" })
vim.keymap.set("n", "<leader>tc", tbi.commands, { desc = "view all commands" })
vim.keymap.set("n", "<leader>tk", tbi.keymaps, { desc = "view all keymaps" })
vim.keymap.set("n", "<leader>twd", tbi.diagnostics, { desc = "entire workspace diagnostics" })
vim.keymap.set("n", "<leader>tt", tbi.builtin, { desc = "telescope builtin" })

vim.keymap.set("n", "<leader>td", function()
  tbi.diagnostics { bufnr = 0}
end, { desc = "current buffer diagnostics" })

--"-H is hidden, -I is ignore, -L is follow, -E is exclude glob
vim.keymap.set("n", "<leader>taf", function()
  tbi.find_files { find_command = {"fd", "-H", "-L", "-E", ".git" }}
end, {desc = "find files custom command no ignore"})

vim.keymap.set("n", "<leader>tif", function()
  tbi.find_files { find_command = {"fd", "-H", "-I", "-L", "-E", ".git" }}
end, {desc = "find files custom command do ignore"})
--" Once you find something <c-x> for open in a horizontal split, <c-v> to open in a vertical split.

