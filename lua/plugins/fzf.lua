return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  -- Seems like a bug. Seems like if you go to a file from fzf-lua you can't run the files command
  -- again, instead you have to resume and resume doesn't always work. By hitting escape you ensure
  -- that resume *will* always work.
  -- By default pressing esc or ctrl-c terminates the fzf process, as such resume is not perfect and
  -- is limited to resuming the picker/query and sometimes additional parameters such as regex in
  -- grep, etc, for a more "complete" resume press alt-esc to hide the fzf process instead, this
  -- will keep the fzf process running in the background and thus will restore the process entirely
  -- including cursor position and selection. To configure hiding by default:
  config = require('fzf-lua').setup(
    { 'fzf-native' },
    { keymap = { builtin = { true, ["<Esc>"] = "hide" } } })
}
