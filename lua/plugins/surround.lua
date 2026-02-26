return {
  "kylechui/nvim-surround",
  version = "*", -- Usa a versão mais estável
  event = "VeryLazy", -- Carrega apenas quando o Neovim estiver ocioso, otimizando o tempo de abertura
  config = function()
    require("nvim-surround").setup({
      -- As configurações padrão são o padrão da indústria
    })
  end
}
