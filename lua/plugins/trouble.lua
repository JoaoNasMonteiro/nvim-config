return {
  "folke/trouble.nvim",
  -- Comando para garantir que o plugin carregue se você digitar :Trouble no terminal
  cmd = "Trouble",

  -- Uma tabela vazia diz ao Lazy para rodar o setup() do plugin com os valores padrão
  opts = {},

  -- Mapeamento preguiçoso (Lazy Loading)
  keys = {
    {
      "<leader>D",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Painel de Diagnósticos do Projeto (Trouble)",
    },
    {
      "<leader>dd",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Diagnósticos Apenas do Buffer Atual",
    },
    -- O Trouble também substitui a Quickfix List padrão para ficar mais bonita
    {
      "<leader>dq",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
