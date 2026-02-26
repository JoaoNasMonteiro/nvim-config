return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- 1. Iniciamos o Mason
    require("mason").setup()

    -- 2. Garantimos a instalação dos nossos LSPs
    require("mason-lspconfig").setup({
      ensure_installed = {
        "clangd",
        "pyright",
      },
    })

    -- 3. Habilitamos os LSPs usando a API nativa moderna do Neovim
    -- O framework antigo "require('lspconfig').setup" foi removido.
    vim.lsp.enable("clangd")
    vim.lsp.enable("pyright")

    -- 4. Criamos os atalhos (Keymaps) APENAS quando o LSP estiver ativo
    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'Ações do LSP',
      callback = function(event)
        local opts = { buffer = event.buf }

        -- gd (Go to Definition): Pula para a definição
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        
        -- K (Hover): Mostra a documentação flutuante
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        
        -- Espaço + r + n (Rename): Renomeia a variável no projeto
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        
        -- Espaço + c + a (Code Action): Sugere correções
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
      end,
    })
  end,
}
