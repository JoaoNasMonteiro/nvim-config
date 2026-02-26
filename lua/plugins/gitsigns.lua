return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      -- Símbolos visuais que aparecerão na margem (Gutter)
      signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      
      -- Esta função injeta os atalhos no arquivo assim que o gitsigns é ativado
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navegação: Pula rapidamente de uma alteração para a próxima/anterior
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true, desc="Pular para próxima alteração Git"})

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true, desc="Pular para alteração anterior Git"})

        -- Ações visuais e de reversão
        -- Espaço + h + p (Hunk Preview): Mostra uma janela flutuante com o que mudou
        map('n', '<leader>hp', gs.preview_hunk, { desc = 'Git: Ver detalhes da alteração' })
        
        -- Espaço + h + r (Hunk Reset): Desfaz as mudanças daquele bloco específico
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'Git: Desfazer alteração no bloco' })
      end
    })
  end,
}
