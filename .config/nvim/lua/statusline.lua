local function git_branch()
  local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
  if branch ~= "" then
    return "  " .. branch .. "  "
  end
  return ""
end

local function file_type()
  local ft = vim.bo.filetype
  local icons = {
    lua        = "[LUA]",
    python     = "[PY]",
    javascript = "[JS]",
    html       = "[HTML]",
    json       = "[JSON]",
    markdown   = "[MD]",
    sh         = "[SH]",
  }
  if ft == "" then return " " end
  return icons[ft] or ft
end

local function lsp_status()
  if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then
    return "  LSP "
  end
  return ""
end

local function file_size()
  local size = vim.fn.getfsize(vim.fn.expand("%"))
  if size < 0 then return "" end
  if size < 1024 then
    return size .. "B "
  elseif size < 1024 * 1024 then
    return string.format("%.1fK", size / 1024)
  else
    return string.format("%.1fM", size / 1024 / 1024)
  end
end

local function mode_icon()
  local modes = {
    n         = "NORMAL",
    i         = "INSERT",
    v         = "VISUAL",
    V         = "V-LINE",
    ["\22"]   = "V-BLOCK",
    c         = "COMMAND",
    s         = "SELECT",
    S         = "S-LINE",
    ["\19"]   = "S-BLOCK",
    R         = "REPLACE",
    r         = "REPLACE",
    ["!"]     = "SHELL",
    t         = "TERMINAL",
  }
  local m = vim.fn.mode()
  return modes[m] or " " .. m:upper()
end

_G.mode_icon   = mode_icon
_G.git_branch  = git_branch
_G.file_type   = file_type
_G.file_size   = file_size
_G.lsp_status  = lsp_status

vim.cmd([[highlight StatusLineBold gui=bold cterm=bold]])
vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  callback = function()
    vim.opt_local.statusline = table.concat({
      " ",
      "%#StatusLineBold#",
      "%{v:lua.mode_icon()}",
      "%#StatusLine#",
      " | %f %h%m%r",
      "%{v:lua.git_branch()}",
      " | ",
      "%{v:lua.file_type()}",
      " | ",
      "%{v:lua.file_size()}",
      " | ",
      "%{v:lua.lsp_status()}",
      "%=",
      "%l:%c %P ",
    })
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  callback = function()
    vim.opt_local.statusline = " %f %h%m%r | %{v:lua.file_type()} | %= %l%c  %P"
  end,
})
