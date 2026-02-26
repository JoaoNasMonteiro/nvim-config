return {
  "nvim-telescope/telescope.nvim",
  -- Recomendado na documentação oficial para evitar que atualizações quebrem a config
  branch = "0.1.x", 
  
  -- Dependência obrigatória
  dependencies = { "nvim-lua/plenary.nvim" },
  
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        -- Ignora pastas pesadas ou desnecessárias nas buscas
        file_ignore_patterns = { ".git/", "node_modules/", "build/" },
      }
    })

    -- Criando os nossos atalhos (Keymaps)!
    -- Lembre-se: O seu <leader> foi configurado como a tecla Espaço no init.lua
    
    -- Espaço + f + f (Find Files): Busca arquivos por nome
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope: Buscar arquivos' })
    
    -- Espaço + f + g (Find Grep): Busca texto DENTRO dos arquivos
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope: Buscar texto' })
    
    -- Espaço + f + b (Find Buffers): Lista os arquivos que já estão abertos
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope: Buscar buffers' })
    
    -- Espaço + f + h (Find Help): Busca nas documentações do Neovim
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope: Buscar ajuda' })
  end,
}
