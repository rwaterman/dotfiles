-- Tool definitions — add new linters/formatters here and list their filetypes in `languages`.
-- Each tool needs the binary available on $PATH (install via Mason UI or system package manager).

local prettier = {
  formatCommand = "prettier --stdin-filepath ${INPUT}",
  formatStdin = true,
}

local eslint = {
  lintCommand = "eslint --stdin --stdin-filename ${INPUT} -f unix",
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %m" },
  rootMarkers = { "package.json", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json" },
}

local stylua = {
  formatCommand = "stylua --stdin-filepath ${INPUT} -",
  formatStdin = true,
}

local ruff_lint = {
  lintCommand = "ruff check --stdin-filename ${INPUT} -",
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %m" },
}

local ruff_format = {
  formatCommand = "ruff format --stdin-filename ${INPUT} -",
  formatStdin = true,
}

-- fixjson handles malformed JSON (trailing commas, comments) that prettier rejects.
-- Run it first so prettier receives valid input.
local fixjson = {
  formatCommand = "fixjson",
  formatStdin = true,
}

local codespell = {
  lintCommand = "codespell --stdin-display-name ${INPUT} -",
  lintStdin = true,
  lintFormats = { "%f:%l: %m" },
}

local shellcheck = {
  lintCommand = "shellcheck --color=never -f gcc -x -",
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %t%*[^:]: %m" },
}

local shfmt = {
  formatCommand = "shfmt -",
  formatStdin = true,
}

local clang_format = {
  formatCommand = "clang-format --assume-filename=${INPUT}",
  formatStdin = true,
}

local languages = {
  lua = { stylua },
  python = { ruff_lint, ruff_format },
  javascript = { prettier, eslint },
  javascriptreact = { prettier, eslint },
  typescript = { prettier, eslint },
  typescriptreact = { prettier, eslint },
  json = { fixjson, prettier },
  yaml = { prettier },
  markdown = { prettier, codespell },
  text = { codespell },
  rst = { codespell },
  gitcommit = { codespell },
  sh = { shellcheck, shfmt },
  bash = { shellcheck, shfmt },
  c = { clang_format },
  cpp = { clang_format },
}

return {
  cmd = { "efm-langserver" },
  filetypes = vim.tbl_keys(languages),
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
  settings = {
    rootMarkers = { ".git/" },
    languages = languages,
  },
}
