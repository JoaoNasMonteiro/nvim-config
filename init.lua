-- ~/.config/nvim/init.lua

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")

require("config.lazy")

require("config.keymaps")

require("config.autocmds")
require("config.hex")

vim.opt.termguicolors = true
