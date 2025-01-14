local ls = require "luasnip"
local types = require "luasnip.util.types"

local snippets_paths = function()
  local paths = {}
  local friendly_snippet_path_root = '/home/jglotzer/.local/share/nvim/lazy/friendly-snippets'
  table.insert(paths, friendly_snippet_path_root)
  local my_snippet_path = "/home/jglotzer/.config/nvim/my-snippets"
  table.insert(paths, my_snippet_path)
  local friendly_snippet_path = friendly_snippet_path_root .. '/snippets'
  table.insert(paths, friendly_snippet_path)
  local lua_snippet_path = friendly_snippet_path_root .. '/snippets/lua'
  table.insert(paths, lua_snippet_path)
  -- print(dump(paths))
  return paths
end

-- require("luasnip.loaders.from_vscode").lazy_load({
--   paths = snippets_paths(),
--   include = nil, -- Load all languages
--   exclude = {},
-- })

ls.config.set_config {
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
    [types.choiceNode] = {
      active = {
        virt_text = { { "⟵", "Error" } },
      },
    },
  },
  paths = snippets_paths(),
  include = nil, -- Load all languages
  exclude = {},
}
