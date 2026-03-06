return {
  "MeanderingProgrammer/render-markdown.nvim",
  -- Load only when you open a Markdown file to save startup time
  ft = { "markdown" }, 
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons", 
  },
  config = function()
    require("render-markdown").setup({
      -- Renders #, ## as clean icons with different sizes/colors
      heading = {
        enabled = true,
        sign = true,
        icons = { 'H ', 'h2 ', 'h3 ', 'h4 ', 'h5 ', 'h6 ' },
      },
      
      -- Creates a distinct visual background for code blocks
      code = {
        enabled = true,
        sign = true,
        style = 'full',
        position = 'left',
      },
      
      -- Flawless table rendering (Replaces | with solid UI lines)
      pipe_table = {
        enabled = true,
        preset = 'round', -- 'heavy', 'double', or 'round' borders
        style = 'full',
      },
      
      -- LaTeX Math rendering (Unicode approximation via Treesitter)
      latex = {
        enabled = true,
        converter = 'latex2text',
        highlight = 'RenderMarkdownMath',
      },
    })
    
    -- Best Practice Keymap: Toggle the rendered view on and off
    -- This is crucial so you can actually edit the raw table pipes if needed
    vim.keymap.set('n', '<leader>m', '<cmd>RenderMarkdown toggle<CR>', { desc = 'Toggle Markdown Render' })
  end,
}
