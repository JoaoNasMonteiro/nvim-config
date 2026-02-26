return {
  "srcery-colors/srcery-vim",
  
  lazy = false,    
  priority = 1000, 
  
  config = function()
    vim.g.srcery_italic = 1
    
    vim.cmd.colorscheme("srcery")
  end,
}
