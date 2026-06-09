-- leader keys (MUST be set before lazy)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable conceallevel (commented out as in original)
-- vim.opt.conceallevel = 2

-- tabs and indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true

-- clipboard
vim.opt.clipboard = "unnamedplus"

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- invisible characters (listchars)
vim.opt.list = true
vim.opt.listchars = {
  tab = "▸ ",
  trail = "·",
  nbsp = "␣",
}

-- diagnostics configuration
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    source = "if_many",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
