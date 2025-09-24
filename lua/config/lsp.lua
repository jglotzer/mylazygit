local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.diagnostic.config({ jump = { float = true } })
local lua_ls_binary = "/home/jglotzer/.local/share/nvim/mason/packages/lua-language-server/lua-language-server"
local lua_ls_root_path = "/home/jglotzer/.local/share/nvim/mason/packages/lua-language-server/libexec"
local js_filetypes = {
  "javascript",
  "typescript",
  "javascriptreact",
  "javascript.jsx",
  "typescriptreact",
  "typescript.tsx",
}

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
  mode = "symbol_text",
  preset = "codicons", --very, very important!
})
-- OK I got codicons working but I guess I sill don't have the function, operator, all that stuff showing up.

cmp.setup({
  completion = {
    completeopt = "menu, menuone, noselect",
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
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
    ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),

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
    ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
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
    { name = "buffer",                 keyword_length = 4,                   max_item_count = 8 },
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
        menu = entry.completion_item.data.detail .. " " .. menu
      end
      vim_item.menu = menu
      return vim_item
    end,
  },
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(), -- important!
    sources = {
      { name = "nvim_lua" },
      { name = "cmdline" },
    },
  }),
  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(), -- important!
    sources = {
      { name = "buffer" },
      { name = "path" },
    },
  }),
})
require("cmp_luasnip")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
  print("Suede the remix god.")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_deep_extend("error",
    { desc = "LSP Buf Hover" }, bufopts))
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_deep_extend("error",
    { desc = "LSP Buf Goto Declaration" }, bufopts))
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_deep_extend("error",
    { desc = "LSP Buf Goto Definition" }, bufopts))
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_deep_extend("error",
    { desc = "LSP Buf Goto Implementation" }, bufopts))
  vim.keymap.set("n", "]e", function() vim.diagnostic.jump({ count = 1 }) end)
  vim.keymap.set("n", "[e", function() vim.diagnostic.jump({ count = -1 }) end)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, vim.tbl_deep_extend("error",
    { desc = "LSP Buf Goto Type Definition" }, bufopts))
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, vim.tbl_deep_extend("error",
    { desc = "LSP Buf Rename" }, bufopts))
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, vim.tbl_deep_extend("error",
    { desc = "LSP Buf Code Action" }, bufopts))
  vim.keymap.set("n", "gr", vim.lsp.buf.references,
    vim.tbl_deep_extend("error", { desc = "LSP Buf References" }, bufopts))
  vim.keymap.set("n", "<space>ZZ", function() vim.lsp.buf.format { async = true } end, { desc = "Format Async" })
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_deep_extend("error",
    { desc = "LSP Buf Signature help" }, bufopts))
  vim.keymap.set("n", "<space>E", vim.diagnostic.open_float, vim.tbl_deep_extend("error",
    { desc = "Open Diagnostic Float" }, bufopts))
  vim.keymap.set("n", "<space>f", vim.lsp.buf.format, vim.tbl_deep_extend("error",
    { desc = "LSP Buf Format" }, bufopts))
  vim.keymap.set("v", "<space>f", vim.lsp.buf.format, vim.tbl_deep_extend("error",
    { desc = "LSP Buf Format" }, bufopts))
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
-- https://xnacly.me/posts/2025/neovim-lsp-changes/
-- require(lspconfig) is now deprecated.
-- Rust config was huge and had an implicit such call so just nuked rust configs.
local lsps = {
    { "ts_ls",
       {
         on_attach = on_attach,
         filetypes = js_filetypes,
         cmd = { "typescript-language-server", "--stdio" },
       }
    },
    { "lua_ls",
       {
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
                    }
                  }
              }
           }
        }
    },
    {
      "bashls",
        {
          capabilities = capabilities,
          cmd = { "/home/jglotzer/.local/share/nvim/mason/bin/bash-language-server", "start" },
          snippetSupport = true,
          on_attach = on_attach,
         }
    },
    {
      "clangd",
        {
           cmd = clangd_cmd,
           root_dir = function()
           ---@diagnostic disable-next-line: undefined-field
           return vim.uv.cwd()
           end,
           on_attach = on_attach,
        }
    },
    {
      "pyright",
        {
          capabilities = capabilities,
          snippetSupport = true,
          on_attach = on_attach,
        }
    },
    {  "marksman",
        {
           on_attach = on_attach,
        }
    },
}

for _, old_lady_judges_watch_people in pairs(lsps) do
    local name, config = old_lady_judges_watch_people[1], old_lady_judges_watch_people[2]
    vim.lsp.enable(name)
    if config then
        vim.lsp.config(name, config)
    end
end

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.completion.spell,
    -- null_ls.builtins.diagnostics.eslint,
    require("none-ls.diagnostics.eslint"),
    null_ls.builtins.formatting.prettier.with({
      enabled_filetypes = js_filetypes,
    }),
  },
})


local snippets_paths = function()
  local friendly_snippets = "/home/jglotzer/.local/share/nvim/lazy/friendly-snippets"
  local my_snippets = "/home/jglotzer/.config/nvim/my-snippets"
  return { friendly_snippets, my_snippets }
end

luasnip.filetype_extend("bash", { "shell" })
local types = require("luasnip.util.types")
luasnip.config.set_config({
  -- This tells Luasnip to remember to keep around the last snippet.
  -- You can jump back to into it even if you move outside the selection.
  history = true,

  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  updateevents = "TextChanged, TextChangedI",

  -- Autosnippets:
  enable_autosnippets = true,

  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "⟵", "Error" } },
      },
    },
  },
})
require("luasnip.loaders.from_vscode").lazy_load({
  paths = snippets_paths(),
  include = nil, -- Load all languages
  exclude = {},
})
