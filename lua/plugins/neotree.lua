return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", 
    "MunifTanjim/nui.nvim",        
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true, 
      
      filesystem = {
        filtered_items = {
          visible = false, 
          hide_dotfiles = false, -- Permite ver arquivos como .gitignore ou .config
          hide_gitignored = true, -- Esconde arquivos ignorados pelo git (ex: pastas build/)
        },
      },
      
      window = {
        position = "left",
        width = 30,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        -- Aqui definimos como navegar dentro da árvore
        mappings = {
          ["<space>"] = "none", -- Desativa o espaço para não conflitar com a nossa tecla leader
          ["l"] = "open",       -- Aperte 'l' para abrir uma pasta ou arquivo
          ["h"] = "close_node", -- Aperte 'h' para fechar uma pasta
          ["a"] = { 
            "add",
            -- Este comando configura o neo-tree para perguntar qual o nome do arquivo a ser criado
            config = {
              show_path = "none" 
            }
          },
          ["d"] = "delete",     -- Aperte 'd' para deletar o arquivo sob o cursor
          ["r"] = "rename",     -- Aperte 'r' para renomear
        }
      }
    })

    -- Atalho principal: Espaço + e (Explorer) abre e fecha a barra lateral
    vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'Alternar Explorador de Arquivos', silent = true })
  end,
}
