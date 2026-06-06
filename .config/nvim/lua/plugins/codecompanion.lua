if vim.g.codecompanion_enabled == false then return end

local openai_model = vim.env.CODECOMPANION_OPENAI_MODEL or "gpt-5-codex-5.5"

require("codecompanion").setup({
  opts = { log_level = "DEBUG" },
  adapters = {
    openai = function()
      return require("codecompanion.adapters").extend("openai", {
        env = { api_key = "OPENAI_API_KEY" },
        schema = { model = { default = openai_model } },
      })
    end,
  },
  strategies = {
    chat = { adapter = "openai" },
    inline = { adapter = "openai" },
  },
})

local function run_cmd(cmd)
  if vim.fn.exists(":" .. cmd) == 2 then
    vim.cmd(cmd)
  else
    vim.notify("CodeCompanion command not available: " .. cmd, vim.log.levels.WARN)
  end
end

vim.keymap.set("n", "<leader>cc", function() run_cmd("CodeCompanionChat") end,    { desc = "CodeCompanion chat" })
vim.keymap.set("n", "<leader>ca", function() run_cmd("CodeCompanionActions") end, { desc = "CodeCompanion actions" })
vim.keymap.set("v", "<leader>ca", function() run_cmd("CodeCompanionActions") end, { desc = "CodeCompanion actions (selection)" })
vim.keymap.set("n", "<leader>ci", function() run_cmd("CodeCompanionInline") end,  { desc = "CodeCompanion inline" })
vim.keymap.set("v", "<leader>ci", function() run_cmd("CodeCompanionInline") end,  { desc = "CodeCompanion inline (selection)" })
