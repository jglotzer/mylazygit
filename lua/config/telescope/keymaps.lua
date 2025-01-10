local tbi = require('telescope.builtin')

vim.keymap.set("n", "<leader>ta", tbi.grep_string, { desc = "Telescope Search Current Word", noremap = true, silent = true })
vim.keymap.set("n", "<leader>tg", tbi.live_grep, { desc = "Telescope Live Grep", noremap = true, silent = true })
vim.keymap.set("n", "<leader>tlg", tbi.live_grep, { desc = "Telescope Live Grep", noremap = true, silent = true })
vim.keymap.set("n", "<leader>tf", tbi.find_files, { desc = "Telescope Find Files", noremap = true, silent = true })
vim.keymap.set("n", "<leader>tb", tbi.buffers, { desc = "Telescope View Buffers", noremap = true, silent = true })
vim.keymap.set("n", "<leader>th", tbi.help_tags, { desc = "Telescope View Help Tags", noremap = true, silent = true })
vim.keymap.set("n", "<leader>tc", tbi.commands, { desc = "Telescope View All Commands", noremap = true, silent = true })
vim.keymap.set("n", "<leader>tk", tbi.keymaps, { desc = "Telescope View All Keymaps", noremap = true, silent = true })
vim.keymap.set("n", "<leader>twd", tbi.diagnostics,
  { desc = "Telescope Entire Workspace Diagnostics", noremap = true, silent = true })
vim.keymap.set("n", "<leader>tt", tbi.builtin, { desc = "Telescope Telescope Builtin", noremap = true, silent = true })

vim.keymap.set("n", "<leader>td", function()
  tbi.diagnostics { bufnr = 0 }
end, { desc = "Telescope Current Buffer Diagnostics", noremap = true, silent = true })

--"-H is hidden, -I is ignore, -L is follow, -E is exclude glob
vim.keymap.set("n", "<leader>taf", function()
  tbi.find_files { find_command = { "fd", "-H", "-L", "-E", ".git" } }
end, { desc = "Telescope Find Files Custom Command No Ignore", noremap = true, silent = true })

vim.keymap.set("n", "<leader>tif", function()
  tbi.find_files { find_command = { "fd", "-H", "-I", "-L", "-E", ".git" } }
end, { desc = "Telescope Find Files Custom Command Do Ignore", noremap = true, silent = true })
-- Once you find something <c-x> for open in a horizontal split, <c-v> to open in a vertical split.
-- And <c-q> opens in quickfix window.
