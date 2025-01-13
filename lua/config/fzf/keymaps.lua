-- https://github.com/benfrain/neovim/blob/ea13388ddf71e7107be3bec8c1cdcc60ceff7223/lua/mappings.lua
local bufopts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>F", require("fzf-lua").files, vim.tbl_deep_extend("error",
  { desc = "FZF Files" }, bufopts))

vim.keymap.set("n", "<leader>ff", require("fzf-lua").files, vim.tbl_deep_extend("error",
  { desc = "FZF Files" }, bufopts))

vim.keymap.set("n", "<leader>mk", require("fzf-lua").marks, vim.tbl_deep_extend("error",
  { desc = "FZF Marks" }, bufopts))

vim.keymap.set("n", "<leader>kk", require("fzf-lua").keymaps, vim.tbl_deep_extend("error",
  { desc = "FZF Keymaps" }, bufopts))

vim.keymap.set("n", "<leader>A", require("fzf-lua").live_grep, vim.tbl_deep_extend("error",
  { desc = "FZF (lazy) Grep" }, bufopts))

vim.keymap.set("n", "<leader>bb", require("fzf-lua").buffers, vim.tbl_deep_extend("error",
  { desc = "FZF Buffers" }, bufopts))

vim.keymap.set("n", "<leader>a", require("fzf-lua").grep_cword, vim.tbl_deep_extend("error",
  { desc = "FZF (C)Word" }, bufopts))

vim.keymap.set("n", "<leader>H", require("fzf-lua").helptags, vim.tbl_deep_extend("error",
  { desc = "FZF Help Tags" }, bufopts))

vim.keymap.set("n", "<leader>ss", require("fzf-lua").spell_suggest, vim.tbl_deep_extend("error",
  { desc = "FZF Spelling Suggestions" }, bufopts))

vim.keymap.set("n", "<leader>dd", require("fzf-lua").lsp_definitions, vim.tbl_deep_extend("error",
  { desc = "FZF Jump to LSP Definition" }, bufopts))

-- vim.keymap.set("n", "<leader><leader>", require("fzf-lua").resume, vim.tbl_deep_extend("error",
--   { desc = "FZF Resume" }, bufopts))
-- vim.keymap.set("n", "<leader>zr", require("fzf-lua").registers, vim.tbl_deep_extend("error",
-- { desc = "Registers" }, bufopts))
-- vim.keymap.set("v", "<leader>z8", require("fzf-lua").grep_visual, vim.tbl_deep_extend("error",
-- { desc = "FZF Selection" }, bufopts))
-- vim.keymap.set("n", "<leader>zgc", require("fzf-lua").git_bcommits, vim.tbl_deep_extend("error",
-- { desc = "Browse File Commits" }, bufopts))
-- vim.keymap.set("n", "<leader>zgs", require("fzf-lua").git_status, vim.tbl_deep_extend("error",
-- { desc = "Git Status" }, bufopts))
