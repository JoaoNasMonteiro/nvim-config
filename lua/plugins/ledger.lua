return {
  {
    "ledger/vim-ledger",
    ft = "ledger", -- O LazyVim só vai carregar o plugin quando você abrir arquivos ledger/journal
    config = function()
      -- 1. Ensina ao Neovim que arquivos .journal devem usar o formato ledger
      vim.filetype.add({
        extension = {
          journal = "ledger",
        },
      })

      -- 2. Configura a largura máxima para o alinhamento com a tecla Tab
      vim.g.ledger_maxwidth = 80

      -- 3. Preenchimento de espaços (o hledger exige pelo menos 2 espaços)
      vim.g.ledger_align_at = 60

      -- 4. Aponta para o seu arquivo de contas para o autocompletar funcionar
      -- ATENÇÃO: Substitua o caminho abaixo pelo caminho real do seu Vault no WSL
      vim.g.ledger_default_acct_file = vim.fn.expand('~/Caminho/Para/O/Seu/Vault/Finances/accounts.journal')
    end,
  }
}
