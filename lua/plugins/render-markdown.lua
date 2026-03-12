return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- CONFIGURAÇÕES NATIVAS DO NEOVIM (Melhor Prática para Conceal)
    -- Habilita a ocultação de sintaxe (esconde a parte da URL dos links)
    vim.opt.conceallevel = 2
    -- Revela a sintaxe crua da linha atual independentemente do modo (Normal, Insert, Visual)
    vim.opt.concealcursor = ""

    require("render-markdown").setup({
      heading = {
        enabled = true,
        sign = true,
        icons = { 'H ', 'h2 ', 'h3 ', 'h4 ', 'h5 ', 'h6 ' },
      },

      code = {
        enabled = true,
        sign = true,
        style = 'full',
        position = 'left',
      },

      pipe_table = {
        enabled = true,
        preset = 'round',
        style = 'full',
      },

      latex = {
        enabled = true,
        converter = 'latex2text',
        highlight = 'RenderMarkdownMath',
      },

      -- NOVA CONFIGURAÇÃO: Customização de Links
      link = {
        enabled = true,
        -- Adiciona um ícone discreto ao lado do alias para você saber que é clicável
        hyperlink = '󰌹 ',
      },

      -- NOVA CONFIGURAÇÃO: Customização de Listas
      bullet = {
        enabled = true,
        -- Substituindo as bolinhas grossas por caracteres Unicode mais finos e limpos
        -- A ordem dita o ícone usado para listas aninhadas (nível 1, nível 2, etc.)
        icons = { '•', '◦', '▪', '▫' },
        left_pad = 0,
        right_pad = 1,
      },
    })

    vim.keymap.set('n', '<leader>m', '<cmd>RenderMarkdown toggle<CR>', { desc = 'Toggle Markdown Render' })
  end,
}
