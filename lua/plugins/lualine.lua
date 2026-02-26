return {
  "nvim-lualine/lualine.nvim",
  -- O lualine também usa os ícones do devicons que já baixamos para o neo-tree
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        -- 'auto' faz a barra herdar automaticamente as cores do tema que vamos instalar
        theme = 'auto',
        
        -- Garante que os ícones bonitos apareçam
        icons_enabled = true,
        
        -- Esses são os separadores clássicos em formato de "seta" das barras modernas
        -- (Eles dependem da Nerd Font do seu terminal para renderizar perfeitamente)
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        
        -- Deixa a barra sempre visível, mesmo se você tiver apenas 1 janela aberta
        always_divide_middle = true,
        globalstatus = true,
      },
      -- Você pode customizar o que aparece em cada seção depois, mas o padrão já é perfeito!
    })
  end,
}
