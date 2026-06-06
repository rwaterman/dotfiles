require("mason").setup()

-- Make mason-installed binaries available to vim.lsp
vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath("data") .. "/mason/bin"

local registry = require("mason-registry")
registry.refresh(function()
  for _, name in ipairs({
    "lua-language-server",
    "typescript-language-server",
    "terraform-ls",
    "gopls",
    "pyright",
    "bash-language-server",
    "clangd",
    "efm",
  }) do
    local ok, pkg = pcall(registry.get_package, name)
    if ok and not pkg:is_installed() then
      pkg:install()
    end
  end
end)

-- efm needs its config here because lua/efm.lua is the user-editable tools file
vim.lsp.config("efm", require("efm"))

vim.lsp.enable({
  "lua_ls",
  "ts_ls",
  "terraformls",
  "gopls",
  "rust_analyzer",
  "pyright",
  "bashls",
  "clangd",
  "cl_lsp",
  "efm",
})

vim.diagnostic.config({
  virtual_lines = { current_line = true },
})
