-- Can always run :4verbose set tw or just :set tw
-- to see what value is being set to
-- Can also type :set or set!
-- also :so %
-- sources current file.
-- https://neovim.io/doc/user/options.html
-- start neovim with -V1 and then
-- :verbose set tw
-- https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
-- https://github.com/nanotee/nvim-lua-guide
-- https://neovim.io/doc/user/lua-guide.html#lua-guide
-- https://www.notonlycode.org/neovim-lua-config/
vim.opt.isfname = vim.o.isfname .. ',@-@' -- :set isfname+=@-@
vim.opt.cmdheight = 1
vim.opt.updatetime = 50
vim.opt.shortmess:append({ c = true })
vim.opt.signcolumn = "auto"
-- Careful, this file can't expand the tilde!
vim.opt.undodir = "/home/jglotzer/.nvim/undodir"
vim.opt.undofile = true
vim.opt.backup = false
vim.opt.wrap = false
vim.opt.errorbells = false
vim.opt.guicursor = ""
vim.opt.termguicolors = true
vim.cmd([[
  set t_Co=256
  ]])
-- vim.cmd.colorscheme "koehler"
vim.cmd.colorscheme "catppuccin"
vim.opt.background = "dark"
vim.opt.compatible = false
vim.opt.foldmethod = "marker"
vim.opt.syntax = "on"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.hlsearch = false
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.ruler = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.scrolloff = 7
vim.opt.hidden = true
vim.opt.tags = "tags;"
vim.opt.tagstack = true
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.timeoutlen = 1000
vim.opt.wildmenu = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.foldlevel = 999
vim.opt.textwidth = 100
vim.opt.clipboard = "unnamedplus"
