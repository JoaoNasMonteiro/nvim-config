return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x", 
  
  dependencies = { "nvim-lua/plenary.nvim" },
  
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        file_ignore_patterns = { ".git/", "node_modules/", "build/" },
      }
    })

    
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope: Buscar arquivos' })
    
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope: Buscar texto' })
    
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope: Buscar buffers' })
    
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope: Buscar ajuda' })
  end,
}
