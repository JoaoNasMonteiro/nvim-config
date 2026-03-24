return {
  "gaoDean/autolist.nvim",
  ft = { "markdown", "text", "markdown.mdx" },
  config = function()
    local autolist = require("autolist")
    
    autolist.setup()

    local autolist_group = vim.api.nvim_create_augroup("AutolistKeymaps", { clear = true })
    
    vim.api.nvim_create_autocmd("FileType", {
      group = autolist_group,
      pattern = { "markdown", "text", "markdown.mdx" },
      callback = function()
        local opts = { buffer = true, silent = true }

        vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>", opts)
        
        vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>", opts)
        vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>", opts)
        
        vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>", opts)
        
        vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>", opts)
        vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>", opts)
        vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>", opts)
        vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>", opts)
      end,
    })
  end,
}
