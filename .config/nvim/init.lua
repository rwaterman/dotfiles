-- leader keys must be set before any plugin loads
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.loader.enable()

require("options")
require("keymaps")
require("autocmds")
require("terminal")
require("statusline")
require("plugins")
require("lsp")
