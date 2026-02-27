local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

vim.opt.clipboard = "unnamedplus"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartindent = true

vim.opt.list = true
vim.opt.listchars = {
  tab = '▸ ',
  trail = '·',
  nbsp = '␣',
}

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      higroup = "Visual",
      timeout = 200,
    })
  end,
})

-- Salvamento Automático Nativo (Simplificado e Robusto)
vim.api.nvim_create_autocmd({ "InsertLeave", "FocusLost" }, {
  pattern = "*", -- Garante que o Neovim saiba que deve monitorar todos os arquivos
  callback = function()
    if vim.bo.modified and vim.bo.modifiable and vim.fn.expand("%") ~= "" then
      vim.cmd("silent! wall")
    end
  end,
})


require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "srcery", "habamax" } },
  checker = { enabled = true },
})
