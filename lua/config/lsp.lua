--local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.diagnostic.config({ jump = { float = true } })

-- Nice utility function gotten from
-- https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console
-- local function dump(o)
--   if type(o) == 'table' then
--     local s = '{ '
--     for k,v in pairs(o) do
--       if type(k) ~= 'number' then k = '"'..k..'"' end
--       s = s .. '['..k..'] = ' .. dump(v) .. ','
--     end
--     return s .. '} '
--   else
--     return tostring(o)
--   end
-- end

---- Setup nvim-cmp.
local cmp = require("cmp")
local luasnip = require("luasnip")
local source_mapping = {
  -- These are just some glyphs that I sorta liked.
  -- 
  -- 
  -- 
  nvim_lsp = "[LSP]  ",
  nvim_lua = "[Lua]  ",
  luasnip = "[Snip] ",
  path = "[Path]  ",
  buffer = "[Buffer]  ",
  gh_issues = "[GitHub] ",
}

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local lspkind = require("lspkind")
lspkind.init({
  --with_text = true,
  mode = 'symbol_text',
  preset = 'codicons', --very, very important!
})
-- OK I got codicons working but I guess I sill don't have the function, operator, all that stuff showing up.

cmp.setup({
  completion = {
    completeopt = 'menu, menuone, noselect'
  },
  dependencies = {
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-lsp-signature-help",
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
    "saadparwaiz1/cmp_luasnip",
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.close(),

    --['Tab'] = tab_key, --again this the aforementioned workaround.
    --I got this from TJ during his video let's see how well it do!
    --and now also got the expanded version from https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end,
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<CR>'] = cmp.mapping.confirm({ select = true })
  },
  -- You can also configure
  -- keyword_length (this is when stuff starts showing up)
  -- priority (but just list order probably enough)
  -- max_item_count
  sources = {
    { name = "nvim_lua" },
    { name = "nvim_lsp_signature_help" },
    { name = "luasnip",                option = { show_autosnippets = true } },
    { name = "nvim_lsp",               max_item_count = 8 },
    { name = "path" },
    { name = "buffer",                 keyword_length = 4,                 max_item_count = 8 },
  },
  -- More TJ
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
  formatting = {
    format = function(entry, vim_item)
      -- JMG very, very important specify codicons here!!!!!
      vim_item.kind = lspkind.presets.codicons[vim_item.kind]
      local menu = source_mapping[entry.source.name]
      if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
        menu = entry.completion_item.data.detail .. ' ' .. menu
      end
      vim_item.menu = menu
      return vim_item
    end
  },
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(), -- important!
    sources = {
      { name = 'nvim_lua' },
      { name = 'cmdline' },
    },
  }),
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(), -- important!
    sources = {
      { name = 'buffer' },
      { name = 'path' },
    },
  })
})
require('cmp_luasnip')

local function config(_config)
  return vim.tbl_deep_extend("force", {
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities),
  }, _config or {})
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
  print("Suede the remix god.")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- TODO: XXX doing this in two places.
  -- So yes doing this in two places. One thing is that we have plugin rust-tools
  -- which overrides the rust config here but then the one in init.vim overrides that one.
  -- That is the thing that caused a lot of confusion and may in fact be what led
  -- me to have the two configs to begin with.
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', ']e', function() vim.diagnostic.jump({ count = 1 }) end)
  vim.keymap.set('n', '[e', function() vim.diagnostic.jump({ count = -1 }) end)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  --vim.keymap.set('n', '<space>F', function() vim.lsp.buf.format { async = true } end, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>E', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
  vim.keymap.set('v', '<space>f', vim.lsp.buf.format, bufopts)
end

-- See https://github.com/LunarVim/LunarVim/issues/2597
local clangd_flags = {
  "--fallback-style=google",
  "--background-index",
  "-j=8",
  "--all-scopes-completion",
  "--pch-storage=disk",
  "--clang-tidy",
  "--log=error",
  "--completion-style=detailed",
  "--header-insertion=iwyu",
  "--header-insertion-decorators",
  "--enable-config",
  "--offset-encoding=utf-16",
  "--ranking-model=heuristics",
  "--folding-ranges",
}

local clangd_bin = "clangd"
local clangd_cmd = { clangd_bin, unpack(clangd_flags) }
local lspconfig = require("lspconfig")

lspconfig.clangd.setup(config({
  --cmd = { "clangd", "--background-index", "--log=verbose" },
  --cmd = { "clangd", "--background-index", "--log=info" },
  cmd = clangd_cmd,
  root_dir = function()
    ---@diagnostic disable-next-line: undefined-field
    return vim.uv.cwd()
  end,
  on_attach = on_attach
}))

lspconfig.bashls.setup {
  capabilities = capabilities,
  cmd = { "/home/jglotzer/.local/share/nvim/mason/bin/bash-language-server", "start" },
  snippetSupport = true,
  on_attach = on_attach
}

local rust_opts = {
  tools = { -- rust-tools options

    -- how to execute terminal commands
    -- options right now: termopen / quickfix / toggleterm / vimux
    executor = require("rust-tools.executors").termopen,

    -- callback to execute once rust-analyzer is done initializing the workspace
    -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
    on_initialized = nil,

    -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
    reload_workspace_from_cargo_toml = true,

    -- These apply to the default RustSetInlayHints command
    inlay_hints = {
      -- automatically set inlay hints (type hints)
      -- default: true
      auto = true,

      -- Only show inlay hints for the current line
      only_current_line = false,

      -- whether to show parameter hints with the inlay hints or not
      -- default: true
      show_parameter_hints = true,

      -- prefix for parameter hints
      -- default: "<-"
      parameter_hints_prefix = "<- ",

      -- prefix for all the other hints (type, chaining)
      -- default: "=>"
      other_hints_prefix = "=> ",

      -- whether to align to the length of the longest line in the file
      max_len_align = false,

      -- padding from the left if max_len_align is true
      max_len_align_padding = 1,

      -- whether to align to the extreme right or not
      right_align = false,

      -- padding from the right if right_align is true
      right_align_padding = 7,

      -- The color of the hints
      highlight = "Comment",
    },

    -- options same as lsp hover / vim.lsp.util.open_floating_preview()
    hover_actions = {

      -- the border that is used for the hover window
      -- see vim.api.nvim_open_win()
      border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      },

      -- Maximal width of the hover window. Nil means no max.
      max_width = nil,

      -- Maximal height of the hover window. Nil means no max.
      max_height = nil,

      -- whether the hover action window gets automatically focused
      -- default: false
      auto_focus = false,
    },

    -- settings for showing the crate graph based on graphviz and the dot
    -- command
    crate_graph = {
      -- Backend used for displaying the graph
      -- see: https://graphviz.org/docs/outputs/
      -- default: x11
      backend = "x11",
      -- where to store the output, nil for no output stored (relative
      -- path from pwd)
      -- default: nil
      output = nil,
      -- true for all crates.io and external crates, false only the local
      -- crates
      -- default: true
      full = true,

      -- List of backends found on: https://graphviz.org/docs/outputs/
      -- Is used for input validation and autocompletion
      -- Last updated: 2021-08-26
      enabled_graphviz_backends = {
        "bmp",
        "cgimage",
        "canon",
        "dot",
        "gv",
        "xdot",
        "xdot1.2",
        "xdot1.4",
        "eps",
        "exr",
        "fig",
        "gd",
        "gd2",
        "gif",
        "gtk",
        "ico",
        "cmap",
        "ismap",
        "imap",
        "cmapx",
        "imap_np",
        "cmapx_np",
        "jpg",
        "jpeg",
        "jpe",
        "jp2",
        "json",
        "json0",
        "dot_json",
        "xdot_json",
        "pdf",
        "pic",
        "pct",
        "pict",
        "plain",
        "plain-ext",
        "png",
        "pov",
        "ps",
        "ps2",
        "psd",
        "sgi",
        "svg",
        "svgz",
        "tga",
        "tiff",
        "tif",
        "tk",
        "vml",
        "vmlz",
        "wbmp",
        "webp",
        "xlib",
        "x11",
      },
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  server = {
    -- standalone file support
    -- setting it to false may improve startup time
    standalone = false,
    on_attach = on_attach,
    snippetSupport = true,
  }, -- rust-analyzer options

  -- debugging stuff
  dap = {
    adapter = {
      type = "executable",
      command = "lldb-vscode",
      name = "rt_lldb",
    },
  },
}

require('rust-tools').setup(rust_opts)

lspconfig.pyright.setup {
  capabilities = capabilities,
  snippetSupport = true,
  on_attach = on_attach
}

local lua_ls_binary = "/home/jglotzer/.local/share/nvim/mason/packages/lua-language-server/lua-language-server"
local lua_ls_root_path = "/home/jglotzer/.local/share/nvim/mason/packages/lua-language-server/libexec"
lspconfig.lua_ls.setup(config({
  capabilities = capabilities,
  snippetSupport = true,
  on_attach = on_attach,
  cmd = { lua_ls_binary, "-E", lua_ls_root_path .. "/main.lua" },
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";"),
        pathStrict = false,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim", "use" },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          --vim.api.nvim_get_runtime_file("", true),
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
      },
    },
  },
}))

local snippets_paths = function()
  local plugins = { "friendly-snippets" }
  local paths = {}
  local path
  local root_path = vim.env.HOME .. "/.config/nvim/plugged/"
  for _, plug in ipairs(plugins) do
    path = root_path .. plug
    if vim.fn.isdirectory(path) ~= 0 then
      table.insert(paths, path)
    end
  end
  -- /home/jglotzer/.local/share/nvim/lazy/friendly-snippets/
  local my_snippet_path = "/home/jglotzer/.lazy/nvim/my-snippets"
  table.insert(paths, my_snippet_path)
  local friendly_snippet_path = '/home/jglotzer/.local/share/nvim/lazy/friendly-snippets/snippets'
  table.insert(paths, friendly_snippet_path)
  local lua_snippet_path = '/home/jglotzer/.local/share/nvim/lazy/friendly-snippets/snippets/lua'
  table.insert(paths, lua_snippet_path)
  --print(dump(paths))
  return paths
end

require("luasnip.loaders.from_vscode").lazy_load({
  paths = snippets_paths(),
  include = nil,  -- Load all languages
  exclude = {},
})
