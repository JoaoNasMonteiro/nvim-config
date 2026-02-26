return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local wk = require("which-key")

    wk.setup({
    })

    wk.add({
      { "<leader>f", group = "Buscar (Telescope)" },
      { "<leader>h", group = "Git (Gitsigns)" },
      { "<leader>c", group = "Código (Ações do LSP)" },
      { "<leader>r", group = "Renomear (LSP)" },
    })
  end,
}
