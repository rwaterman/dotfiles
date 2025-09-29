-- theme & transparency
vim.cmd.colorscheme("unokai")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

-- Basic settings
vim.opt.number = true   -- Line numbers
vim.opt.relativenumber = false  -- Relative line numbers
vim.opt.cursorline = true -- Highlight current line
vim.opt.wrap  = true    -- Don't wrap lines
vim.opt.scrolloff = 10    -- Keep 10 lines above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor

-- Intentation
vim.opt.tabstop = 2   -- Tab width
vim.opt.shiftwidth = 2    -- Indent width
vim.opt.softtabstop = 2   -- Soft tab stop
vim.opt.expandtab = true  -- Use spaces instead of tabs
vim.opt.smartindent = true  -- Smart auto-indenting
vim.opt.autoindent = true -- Copy indent from current line

-- Search Settings
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true  -- Case sensitive if uppercase in search
vim.opt.hlsearch = false  -- Don't highlight search results
vim.opt.incsearch = true  -- Show matches as you type

-- Visual settings
vim.opt.termguicolors = true  -- Enable 24-bit colors
vim.opt.signcolumn = "yes"  -- Always show sign column
vim.opt.colorcolumn = "120" -- Show column at 100 characters
vim.opt.showmatch = true  -- Highlight matching brackets
vim.opt.matchtime = 2     -- How long to show matching bracket
vim.opt.cmdheight = 1     -- Command line height
vim.opt.completeopt = "menuone,noinsert,noselect" -- Completion options
vim.opt.showmode = false  -- Don't show mode in command line
vim.opt.pumheight = 10   -- Popup menu height
vim.opt.pumblend = 10     -- Popup menu transparency
vim.opt.winblend = 0      -- Floating window transparency
vim.opt.conceallevel = 0  -- Don't hide markup
vim.opt.concealcursor = ""  -- Don't hide cursor line markup
vim.opt.lazyredraw = true   -- Don't redraw during macros
vim.opt.synmaxcol = 300     -- Syntax highlighting limit

-- File handling
vim.opt.backup = false    -- Don't create backup files
vim.opt.writebackup = false -- Don't create backup before writing
vim.opt.swapfile = false    -- Don't create swap files
vim.opt.undofile = true     -- Persistent undo
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.updatetime = 300 -- Faster completion
vim.opt.timeoutlen = 500 -- Key timeout duration
vim.opt.ttimeoutlen = 0   -- Key code timeout
vim.opt.autoread = true   -- Auto reload files changed outside vim
vim.opt.autowrite = false   -- Don't auto save

-- Behavior settings
vim.opt.hidden = true   -- Allow hidden buffers
vim.opt.errorbells = false    -- No error bells
vim.opt.backspace = "indent,eol,start" -- Better backspace behavior
vim.opt.autochdir = false -- Don't auto change directory
vim.opt.iskeyword:append("-")   -- Treat dash as part of word
vim.opt.path:append("**")   -- Include subdirectories in search
vim.opt.selection = "exclusive" -- Selection behavior
vim.opt.mouse = "a" -- Enable mouse behavior
vim.opt.clipboard:append("unnamedplus") -- Use system clipboard
vim.opt.modifiable = true   -- Allow buffer modifications
vim.opt.encoding = "UTF-8"

-- Cursor settings
vim.opt.guicursor = {
  "n-v-c:block", -- Normal, Visual, Command-line
  "i-ci-ve:block", -- Insert, Command-line Insert, Visual-exclusive
  "r-cr:hor20",  -- Replace, Command-lie Replace
  "o:hor50", -- Operator-pending
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor", -- All modes: blinking & highlight groups
  "sm:block-blinkwait175-blinkoff150-blinkon175", -- Showmatch mode
}

-- Fold Settings
vim.opt.foldmethod = "expr"  -- Use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter for folding
vim.opt.foldlevel = 99  -- Keep all folds open by default

-- Split behavior
vim.opt.splitbelow = true -- Horizontal splits open below
vim.opt.splitright = true -- Vertical splits open to the right

-- Y to EOL
vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })

-- Key Mappings
vim.g.mapleader = " "  -- Set leader key to space
vim.g.maplocalleader = " " -- Set local leader key (NEW)

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

-- Splitting & Resizing
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })



