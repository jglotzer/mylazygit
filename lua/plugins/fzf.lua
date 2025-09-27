return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  config = require("fzf-lua").setup({ "fzf-native" }),
}
