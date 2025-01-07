
-- Work with panes
vim.keymap.set("n", "<F9>", "<C-W><C-R>", { desc = "Switch Diff panes around", noremap = true, silent = true })
vim.keymap.set("n", "<F12>", "<C-W><C-W>", { desc = "Go to other Window", noremap = true, silent = true })

-- Toggle Line Numbering
vim.keymap.set("n", "<F11>", "<Cmd>set nu! rnu! <CR>", { desc = "Toggle line numbers", noremap = true, silent = true })

-- In visual mode move selected blocks up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {})

-- Terminal mode escape.
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
