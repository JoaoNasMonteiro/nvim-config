return {
  "stevearc/conform.nvim",
  -- Carrega o plugin antes de salvar qualquer arquivo
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },

  -- Atalho manual caso você queira formatar sem salvar
  keys = {
    {
      "<leader>F",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format code",
    },
  },

  opts = {
    -- MELHOR PRÁTICA: Mapeamento estrito de formatadores por linguagem
    formatters_by_ft = {
      lua = { "stylua" },
      -- Em Python, o isort organiza as bibliotecas no topo, o black formata o resto
      python = { "isort", "black" },
      c = { "clang-format" },
      cpp = { "clang-format" },
    },

    -- Automação de salvamento (Format on Save)
    format_on_save = {
      -- Tempo máximo que o Neovim vai esperar o formatador responder
      timeout_ms = 500,
      -- Se a linguagem não tiver formatador CLI definido acima, usa o LSP (ex: clangd)
      lsp_fallback = true,
    },
  },
}
