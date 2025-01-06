return {
    'neovim/nvim-lspconfig',
     dependencies = {'saghen/blink.cmp'},
     config = function()
       local lspconfig = require("lspconfig")
       local capabilities = require("blink.cmp").get_lsp_capabilities()
       lspconfig.lua_ls.setup({
          settings = {
              diagnostics = {
                  -- Get the language server to recognize the `vim` global
               globals = { "vim", "use" },
              },
          },
          capabilities = capabilities,
       })
       vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
       vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
     end
}
