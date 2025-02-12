local luasnip = require "luasnip"
local luasnipTypes = require "luasnip.util.types"

local snippets_paths = function()
  local friendly_snippets = '/home/jglotzer/.local/share/nvim/lazy/friendly-snippets'
  local my_snippets = "/home/jglotzer/.config/nvim/my-snippets"
  return { friendly_snippets, my_snippets }
end

luasnip.filetype_extend("bash", { "shell" })
luasnip.config.set_config {
  -- This tells Luasnip to remember to keep around the last snippet.
  -- You can jump back to into it even if you move outside the selection.
  history = true,

  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  updateevents = "TextChanged, TextChangedI",

  -- Autosnippets:
  enable_autosnippets = true,

  --Crazy highlights!!
  -- #vid3
  -- ext_opts = nil,
  ext_opts = {
    [luasnipTypes.choiceNode] = {
      active = {
        virt_text = { { "⟵", "Error" } },
      },
    },
  },
  paths = snippets_paths(),
  include = nil, -- Load all languages
  exclude = {},
}
