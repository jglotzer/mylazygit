
local tbi = require('telescope.builtin')

vim.keymap.set("n", "<leader>ta", tbi.grep_string, { desc = "Telescope Search Current Word" })
vim.keymap.set("n", "<leader>tg", tbi.live_grep, { desc = "Telescope Live Grep" })
vim.keymap.set("n", "<leader>tlg", tbi.live_grep, { desc = "Telescope Live Grep" })
vim.keymap.set("n", "<leader>tf", tbi.find_files, { desc = "Telescope Find Files" })
vim.keymap.set("n", "<leader>tb", tbi.buffers, { desc = "Telescope View Buffers" })
vim.keymap.set("n", "<leader>th", tbi.help_tags, { desc = "Telescope View Help Tags" })
vim.keymap.set("n", "<leader>tc", tbi.commands, { desc = "Telescope View All Commands" })
vim.keymap.set("n", "<leader>tk", tbi.keymaps, { desc = "Telescope View All Keymaps" })
vim.keymap.set("n", "<leader>twd", tbi.diagnostics, { desc = "Telescope Entire Workspace Diagnostics" })
vim.keymap.set("n", "<leader>tt", tbi.builtin, { desc = "Telescope Telescope Builtin" })

vim.keymap.set("n", "<leader>td", function()
  tbi.diagnostics { bufnr = 0}
end, { desc = "Telescope Current Buffer Diagnostics" })

--"-H is hidden, -I is ignore, -L is follow, -E is exclude glob
vim.keymap.set("n", "<leader>taf", function()
  tbi.find_files { find_command = {"fd", "-H", "-L", "-E", ".git" }}
end, {desc = "Telescope Find Files Custom Command No Ignore"})

vim.keymap.set("n", "<leader>tif", function()
  tbi.find_files { find_command = {"fd", "-H", "-I", "-L", "-E", ".git" }}
end, {desc = "Telescope Find Files Custom Command Do Ignore"})
--" Once you find something <c-x> for open in a horizontal split, <c-v> to open in a vertical split.

