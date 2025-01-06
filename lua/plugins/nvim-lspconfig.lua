---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
  print("Suede the remix god.")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = {noremap=true, silent=true, buffer=bufnr}
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', ']e', function() vim.diagnostic.jump({count=1}) end)
  vim.keymap.set('n', '[e', function() vim.diagnostic.jump({count=-1}) end)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>F', function() vim.lsp.buf.format { async = true } end, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>E', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
  vim.keymap.set('v', '<space>f', vim.lsp.buf.format, bufopts)
end

return {
    'neovim/nvim-lspconfig',
     dependencies = {'saghen/blink.cmp'},
     config = function()
       local lspconfig = require("lspconfig")
       local capabilities = require("blink.cmp").get_lsp_capabilities()
       -- LUA LS setup
       lspconfig.lua_ls.setup({
          Lua = {
            completion = {
              callSnippet = "Replace",
             }
          },
          settings = {
              diagnostics = {
                  -- Get the language server to recognize the `vim` global
               globals = { "vim", "use" },
              },
          },
          on_attach = on_attach,
          capabilities = capabilities,
       })
       -- BASH LS setup
       lspconfig.bashls.setup ({
       capabilities = capabilities,
       cmd = {"/home/jglotzer/.local/share/nvim/mason/bin/bash-language-server", "start"},
       snippetSupport = true,
       on_attach = on_attach,
      })
     end
}
