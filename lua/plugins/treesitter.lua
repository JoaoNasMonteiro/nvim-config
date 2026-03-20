return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  -- Na branch main, lazy = false é a melhor prática para garantir
  -- que a API do TS esteja disponível na inicialização antes dos arquivos abrirem
  lazy = false,

  config = function()
    local ts = require("nvim-treesitter")

    -- 1. Instalação Assíncrona de Parsers
    -- O plugin baixa se faltar algum, e ignora (no-op) se já estiverem no disco.
    ts.install({
      "c", "cpp", "lua", "markdown", "markdown_inline",
      "python", "vim", "vimdoc", "query", "make", "latex", "ledger", "bash"
    })

    -- 2. Ativação Nativa (O Padrão Ouro do Neovim 0.10+)
    -- Escuta a abertura de qualquer arquivo e injeta a inteligência sintática
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function(args)
        -- Tenta ligar o motor sintático nativo para o buffer atual de forma segura
        local ok = pcall(vim.treesitter.start, args.buf)

        -- Se o Neovim possuir o parser da linguagem e iniciar com sucesso:
        if ok then
          -- Delega a regra de indentação deste buffer para o treesitter
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
