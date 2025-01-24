-- Work with panes
vim.keymap.set("n", "<F9>", "<C-W><C-R>", { desc = "Switch Diff panes around", noremap = true, silent = true })
vim.keymap.set("n", "<F12>", "<C-W><C-W>", { desc = "Go to other Window", noremap = true, silent = true })

-- Toggle Line Numbering
vim.keymap.set("n", "<F11>", "<Cmd>set nu! rnu! <CR>", { desc = "Toggle line numbers", noremap = true, silent = true })

-- In visual mode move selected blocks up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move block down", noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move block up", noremap = true, silent = true })

-- Terminal mode escape.
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Terminal mode escape", noremap = true, silent = true })

-- Quickly insert an empty new line without entering insert mode
vim.keymap.set("n", "<leader>o", "o<esc>",
  { desc = "Empty newline below, stay in normal mode", noremap = true, silent = true })
vim.keymap.set("n", "<leader>O", "O<esc>",
  { desc = "Empty newline above, stay in normal mode", noremap = true, silent = true })

-- TJ - SpaceX SpaceSpaceX source code
-- https://youtu.be/CuWfgiwI73Q?si=8cf6G1lIBBImS7G-&t=1456
vim.keymap.set("n", "<space><space>x", "<cmd>.lua<CR>",
  { desc = "Source the current line", noremap = true, silent = true })
vim.keymap.set("n", "<space>x", "<cmd>source %<CR>",
  { desc = "Source the current file", noremap = true, silent = true })
--print("Thanks TJ!")
--These mappings control the size of the splits
vim.keymap.set("n", "<M-Left>", "<c-w>5>", { desc = "Alt left arrow to move split left", noremap = true, silent = true })
vim.keymap.set("n", "<M-Right>", "<c-w>5<",
  { desc = "Alt right arrow to move split right", noremap = true, silent = true })
vim.keymap.set("n", "<M-Up>", "<c-W>5+>", { desc = "Alt up arrow to move split up", noremap = true, silent = true })
vim.keymap.set("n", "<M-Down>", "<c-W>5-<", { desc = "Alt down arrow to move split down", noremap = true, silent = true })

vim.keymap.set("n", "<leader><CR>", "<cmd>source /home/jglotzer/.config/nvim/init.lua<CR>",
  { desc = "Source init.lua (shoutout)", noremap = true, silent = true })

-- Could make this more complicated but for now this seems a decent start.
function AutoCompleteOff()
    require('cmp').setup({
      completion = {
        autocomplete = false
      }
    })
end
vim.cmd('command AutoCmpOff lua AutoCompleteOff()')

