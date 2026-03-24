return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({
    })

    local cmp_autopairs_status, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
    local cmp_status, cmp = pcall(require, "cmp")
    
    if cmp_autopairs_status and cmp_status then
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  end,
}
