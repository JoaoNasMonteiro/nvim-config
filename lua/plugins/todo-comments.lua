return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  -- Carrega o plugin de forma assíncrona apenas quando abre um ficheiro real
  event = { "BufReadPost", "BufNewFile" },
  
  config = function()
    require("todo-comments").setup({
      -- Uma lista vazia assume as configurações padrão, que já definem 
      -- as cores e os ícones perfeitamente para o seu colorscheme Srcery.
    })
  end,
  
  keys = {
    -- 1. Navegação Tática (com a mão no teclado, dentro do ficheiro)
    { 
      "]t", 
      function() require("todo-comments").jump_next() end, 
      desc = "Saltar para o próximo TODO" 
    },
    { 
      "[t", 
      function() require("todo-comments").jump_prev() end, 
      desc = "Saltar para o TODO anterior" 
    },
    
    -- 2. Visão Panorâmica (O Painel Estilo LogSeq)
    { 
      "<leader>tt", 
      "<cmd>Trouble todo toggle<cr>", 
      desc = "Painel de TODOs do Projeto (Trouble)" 
    },
    
    -- 3. Pesquisa Dinâmica (Filtro via Telescope)
    { 
      "<leader>tf", 
      "<cmd>TodoTelescope<cr>", 
      desc = "Pesquisar TODOs no Telescope" 
    },
  },
}
