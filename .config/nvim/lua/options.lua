vim.api.nvim_set_hl(0, "Normal", { bg = "none" })       -- transparent background
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })     -- transparent for non-current windows
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })  -- transparent end-of-buffer tildes

vim.opt.number = true           -- show absolute line numbers
vim.opt.relativenumber = false  -- no relative numbers
vim.opt.cursorline = true       -- highlight the current line
vim.opt.wrap = true             -- soft-wrap long lines
vim.opt.scrolloff = 10          -- keep 10 lines visible above/below cursor
vim.opt.sidescrolloff = 8       -- keep 8 columns visible left/right of cursor

vim.opt.tabstop = 2       -- a tab character renders as 2 spaces
vim.opt.shiftwidth = 2    -- >> and << indent by 2 spaces
vim.opt.softtabstop = 2   -- <Tab> in insert mode inserts 2 spaces
vim.opt.expandtab = true  -- insert spaces instead of tab characters
vim.opt.smartindent = true  -- auto-indent new lines based on syntax
vim.opt.autoindent = true   -- copy indent from previous line

vim.opt.ignorecase = true  -- case-insensitive search by default
vim.opt.smartcase = true   -- case-sensitive when pattern contains uppercase
vim.opt.hlsearch = false   -- don't persist search highlights after moving
vim.opt.incsearch = true   -- highlight matches as you type

vim.opt.termguicolors = true   -- 24-bit RGB color in terminal
vim.opt.signcolumn = "yes"     -- always show the sign column (gutter)
vim.opt.colorcolumn = "120"    -- vertical ruler at column 120
vim.opt.showmatch = true       -- briefly jump to matching bracket on insert
vim.opt.matchtime = 2          -- show matching bracket for 0.2s
vim.opt.cmdheight = 1          -- command-line height
vim.opt.completeopt = "menuone,noinsert,noselect"  -- completion menu behavior
vim.opt.showmode = false   -- don't show -- INSERT -- etc. (statusline handles it)
vim.opt.pumheight = 10     -- max items shown in the completion popup
vim.opt.pumblend = 10      -- popup menu pseudo-transparency (0=opaque)
vim.opt.winblend = 0       -- floating window pseudo-transparency
vim.opt.conceallevel = 0   -- show concealed characters as-is
vim.opt.concealcursor = "" -- never conceal on the cursor line
vim.opt.lazyredraw = true  -- don't redraw during macros (faster execution)
vim.opt.synmaxcol = 300    -- stop syntax highlighting past column 300
vim.opt.winborder = "rounded"  -- default border style for floating windows

vim.opt.backup = false       -- don't create backup files before saving
vim.opt.writebackup = false  -- don't create a backup during the write
vim.opt.swapfile = false     -- no swap files
vim.opt.undofile = true      -- persist undo history to disk
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")  -- directory for undo files
vim.opt.updatetime = 300    -- ms before writing swap / triggering CursorHold
vim.opt.timeoutlen = 500    -- ms to wait for a mapped sequence to complete
vim.opt.ttimeoutlen = 10    -- ms to wait for a key code sequence
vim.opt.autoread = true     -- reload file if changed outside nvim
vim.opt.autowrite = false   -- don't auto-save on buffer switch

vim.opt.hidden = true         -- allow switching buffers without saving
vim.opt.errorbells = false    -- no bell on errors
vim.opt.backspace = "indent,eol,start"  -- backspace over autoindent, EOL, insert start
vim.opt.autochdir = false     -- don't change cwd when switching buffers
vim.opt.iskeyword:append("-")  -- treat hyphen as part of a word
vim.opt.path:append("**")     -- search recursively with :find
vim.opt.selection = "exclusive"  -- visual selection excludes the character under cursor
vim.opt.mouse = "a"           -- enable mouse in all modes
vim.opt.clipboard:append("unnamedplus")  -- sync yank/paste with system clipboard
vim.opt.modifiable = true     -- allow buffer modifications
vim.opt.encoding = "UTF-8"    -- default file encoding

vim.opt.guicursor = {
  "n-v-c:block",           -- block cursor in normal/visual/command
  "i-ci-ve:block",         -- block cursor in insert mode
  "r-cr:hor20",            -- horizontal bar (20%) in replace
  "o:hor50",               -- horizontal bar (50%) in operator-pending
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",  -- blink timing
  "sm:block-blinkwait175-blinkoff150-blinkon175",          -- showmatch blink
}

vim.opt.foldmethod = "expr"                           -- fold via expression
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"  -- use treesitter for folds
vim.opt.foldlevel = 99  -- start with all folds open

vim.opt.splitbelow = true  -- horizontal splits open below current window
vim.opt.splitright = true  -- vertical splits open to the right

vim.opt.wildmenu = true                -- enable enhanced command-line completion
vim.opt.wildmode = "longest:full,full" -- complete longest match, then cycle
vim.opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })  -- skip compiled artifacts

vim.opt.diffopt:append("linematch:60")  -- align diff hunks by matching up to 60 lines

vim.opt.redrawtime = 10000    -- ms allowed for syntax highlighting before giving up
vim.opt.maxmempattern = 20000 -- KB of memory for pattern matching

local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
