-- Markdown specific settings
vim.opt.wrap = true -- Wrap text
vim.opt.breakindent = true -- Match indent on line break
vim.opt.linebreak = true -- Line break on whole words
vim.opt.textwidth = 100

-- Allow j/k when navigating wrapped lines
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Spell check
-- <space>ss gives spelling suggestions via FZF
-- z= also gives spelling suggestions
-- zg marks word as correct
vim.opt.spelllang = 'en_us,fr'
-- vim.opt.spell = true
