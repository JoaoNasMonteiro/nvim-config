-- ~/.config/nvim/init.lua

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")

require("config.lazy")

require("config.keymaps")

require("config.autocmds")
require("config.hex")
require("config.jupyter")

vim.opt.termguicolors = true
