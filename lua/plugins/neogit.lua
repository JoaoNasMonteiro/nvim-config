return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local neogit = require("neogit")
    neogit.setup({

    })

    vim.keymap.set("n", "<leader>gs", neogit.open, { desc = "Open Neogit (Status)" })
    vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>", { desc = "Neogit Quick Commit" })
  end,
}
