return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  -- Como não definimos 'lazy = true', o lazy.nvim vai carregar este plugin na inicialização,
  -- MAS ele só vai executar a função abaixo DEPOIS de garantir que o plugin está no 'runtimepath'.
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { 
        "c", 
        "cpp", 
        "python", 
        "make", 
        "lua", 
        "vim", 
        "vimdoc", 
        "query", 
        "markdown" 
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    })
  end,
}
