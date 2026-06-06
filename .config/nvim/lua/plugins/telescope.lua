local builtin = require("telescope.builtin")

vim.keymap.set("n", "<C-p>", function()
  builtin.find_files({ hidden = false, no_ignore = false })
end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
