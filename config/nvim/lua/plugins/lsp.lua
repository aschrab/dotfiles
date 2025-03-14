return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local opts = { noremap=true, silent=true }
      vim.keymap.set('n', '<space>e', function()
        vim.diagnostic.open_float({ header = 'Diagnostics', border = 'rounded' })
      end, opts)

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
      end

      local lsp_flags = {
        -- This is the default in Nvim 0.7+
        debounce_text_changes = 150,
      }

      local capabilities = {}

      local status, lsp = pcall(require, 'cmp_nvim_lsp')
      if (status) then
        capabilities = lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
      end

      require('lspconfig')['ts_ls'].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
      }

      require('lspconfig')['volar'].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
      }

      require('lspconfig')['bashls'].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
      }

      require('lspconfig')['gopls'].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
      }

      require('lspconfig')['solargraph'].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
      }

      require'lspconfig'.pylyzer.setup{}
    end
  }
}
