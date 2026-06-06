local gh = function(x) return "https://github.com/" .. x end

vim.pack.add({
  { src = gh("catppuccin/nvim"),               name = "catppuccin" },
  { src = gh("nvim-lua/plenary.nvim") },
  { src = gh("nvim-telescope/telescope.nvim"), version = "0.1.8" },
  { src = gh("olimorris/codecompanion.nvim") },
})

vim.cmd.colorscheme("catppuccin")

require("plugins.telescope")
require("plugins.codecompanion")
