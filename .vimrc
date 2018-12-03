" @author Rick Waterman richardwaterman@gmail.com
" @license MIT

set mouse+=a                 " Enable the mouse and enable tmux hack
if &term =~ '^screen'
  " tmux knows the extended mouse mode
  set ttymouse=xterm2
endif


if has('gui_running')
  set guifont=Meslo\ LG\ M\ DZ\ Regular\ for\ Powerline:h14
endif

set backspace=2
set    encoding=utf-8           " Set text encoding as UTF-8
syntax on                       " Syntax highlighting
set    number                   " Turn line numbering ON
set    swapfile                 " Use a swap file when editing
set    backup                   " Turn on file backups
set    writebackup
set    backupdir=~/tmp/vim,~    " Backup files in ~/tmp/vim or ~
set    cc=120                   " A guide to help me from writing more than 80 characters per line
set    complete+=kspell         " Spellcheck word completion with C-n & C-p in insert mode
set    mousemodel=popup         " When a cursor is placed under a word and the iright mouse button is clicked, different spell check word suggestions are given.
set    directory=~/tmp/vim,~,.  " Backup directory
set    ffs=unix                 " Use Unix-style newlines as the standard file type
set    ignorecase               " case insensitive search
set    hlsearch                 " highlight matches
set    showmatch                " live match highlighting
set    incsearch                " live incremental searching
set    nocompatible             " Turns off VI compatibility mode
set    nostartofline            " Don't reset cursor to start of line when moving around
set    ruler                    " Show the current position
set    shortmess=atI            " Disable the intro message when starting Vim
set    showcmd                  " Show the (partial) command when being typed
set    cursorcolumn             " Highlights all characters on the same collumn as cursor
set    smartcase                " If there are uppercase letters, become case-sensitive.
set    smartindent              " Intellegently dedent / indent new lines based on rules.
set    autoindent               " Match indents on new lines.
set    smarttab                 " let's tab key insert 'tab stops', and bksp deletes tabs.
set    expandtab                " Use space characters instead of a tab character
set    tabstop=2                " How many columns a tab will count for
set    shiftwidth=2             " The number of columns/spaces for indents/dedents
set    softtabstop=2            " The number of spaces to account for when pressing tab, specifically in Insert Mode
set    shiftround               " Round indent to multiple of shifttab
set    ttimeoutlen=100          " Prevents vi from waiting too long after exiting Insert Mode
set    ttyfast                  " Optimize for fast terminal connections
set    virtualedit+=block       " allow the cursor to go anywhere in visual block mode.
set    wildmenu                 " Enhanced command line completion
set    wildignore=*.o,*.obj,*.bak,*.exe,*.out " Avoid opening binary file types
set    nolist                   " List on disables linebreak above
set    wm=0 tw=0                " Prevents Vim from inserting too many newlines.
set    wrap linebreak           " Wrap text but fit entire words on a line.
set    viminfo^=%               " Remember info about open buffers on close
map    q <Nop>|                 " Disable recording
set indentexpr=                 " Fixes auto indent issues
set spelllang=en_us

" Specify proper behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry


" AUTOCMDs

" Return to last edit position when opening files
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" Enable Spell Check on certain file types
au BufRead,BufNewFile *.md setlocal spell cc=0 nolist

" Delete trailing white spaces for space sensitive file types
au BufWrite *.py,*.coffee,*.jade :call StripWhitespace()

" Set the tab spacing to a different amount for these filetypes
au BufRead,BufNewFile *.styl,*.jade setlocal inde=


" FUNCTIONS

" Bclose(): Don't close window a when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")

  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif

  if bufnr("%") == l:currentBufNum
    new
  endif

  if buflisted(l:currentBufNum)
    execute("bdelete! ".l:currentBufNum)
  endif
endfunction

" Function to strip trailing whitespace
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction

" ZoomToggle(): Zoom / Restore window with Ctrl+W, then 'z'
function! s:ZoomToggle() abort
  if exists('t:zoomed') && t:zoomed
    execute t:zoom_winrestcmd
    let t:zoomed = 0
  else
    let t:zoom_winrestcmd = winrestcmd()
    resize
    vertical resize
    let t:zoomed = 1
  endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-w>z  :ZoomToggle<CR>


" # KEYBOARD SHORTCUTS AND MAPPINGS
" Vim by default won't let you move down one line to the wrapped portion. This fixes that.
noremap j gj
noremap k gk

" Save a shift key press to enter Command mode
nnoremap ; :

" So we don't have to reach for escape to leave insert mode.
inoremap jf <ESC>

" CTRL-s to save file
noremap  <silent> <C-s> :update<CR>
vnoremap <silent> <C-s> <C-C>:update<CR>
inoremap <silent> <C-s> <C-O>:update<CR>

" Automatically jump to the end of pasted text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Quickly select text I just pasted
noremap gV `[v`]

let mapleader=',' " Set the leader key to the ',' character

" Clear whitespace quickly
map <leader>ss :call StripWhitespace()<cr>

" Close the current buffer without closing all the tabs, too
map <leader>bw :Bclose<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove


" # PLUGINS
call plug#begin('~/.vim/plugged') " Call vim-plug
" Plug 'Valloric/YouCompleteMe'
" Plug 'vimwiki/vimwiki'

" ## PLUGINS: STYLING
Plug 'flazz/vim-colorschemes' " Colorschemes
set t_ut= " Disabled Background Color Erase
set t_Co=256 " Ensure Vim uses 256 colors
set background=dark

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes' " Pretty statuslines (patched Powerline fonts required)
set laststatus=2
let g:airline_theme = 'jellybeans'
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'
set noshowmode

" ## PLUGINS: EFFICIENCY HACKS
Plug 'airblade/vim-gitgutter'  " Git diff symbols while editing
Plug 'tpope/vim-fugitive'      " Git wrapper
Plug 'kshenoy/vim-signature'   " Show marks

" Plug 'bling/vim-bufferline' "airline plugin to show buffers on status line
" let g:bufferline_rotate = 1

Plug 'ctrlpvim/ctrlp.vim'   " Ctrl+p and Ctrl+p funky are for fuzzy searching buffers and functions
Plug 'tacahiroy/ctrlp-funky'
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_extensions = ['funky']
nnoremap <Leader>fu :CtrlPFunky<Cr>
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>| " narrow the list down with a word under cursor
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Plug 'godlygeek/tabular'    " Tabulated Text Alignment Helper
" Plug 'dkprice/vim-easygrep' " Easy Grep
Plug 'tpope/vim-commentary' " Support for easily toggling things.

" Plug 'tpope/vim-repeat'     " Repeat (.) functionality enhancement

" Plug 'tpope/vim-surround'   " A character/tag surrounder

" Plug 'tpope/vim-unimpaired' " Complementary Mapping pairs

Plug 'scrooloose/nerdtree' " File tree navigator and bookmarks
map <C-n> :NERDTreeToggle<CR>

" Plug 'yggdroot/indentLine'             " Add dotted lines between code indents
" let g:indentLine_char = '┆'
" Plug 'conradIrwin/vim-bracketed-paste' " No more :set paste when copying from clipboard

Plug 'junegunn/vim-pseudocl'           " A dependency for some Plug packages

" Plug 'junegunn/vim-oblique'            " Improved search and fuzzy searching

" Plug 'junegunn/goyo.vim'               " Distraction free mode

" Plug 'keith/investigate.vim'           " Help assistant for looking up functions, etc.

Plug 'mbbill/undotree'
if has("persistent_undo")
  set undodir='~/tmp/'
  set undofile
endif
nnoremap <F5> :UndotreeToggle<cr>

Plug 'Chiel92/vim-autoformat' " Autoformat code. See page for packages to install on your system.
noremap <F3> :Autoformat<CR>

" Plug 'Valloric/MatchTagAlways'

" Plug 'junegunn/vim-easy-align' " Easily align content in text files in a tabulated fashion

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

Plug 'terryma/vim-expand-region' " Visually select larger regions of code using the same key combination
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" ## SYNTAX HIGHLIGHTING & LINTERS
Plug 'scrooloose/syntastic' " General purpose linting system
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn
" let g:syntastic_coffee_coffeelint_args = "--file /home/$USER/coffeelint.json"
" Plug 'pangloss/vim-javascript'  " Javascript Syntax
" Plug 'cakebaker/scss-syntax.vim' " Sass
Plug 'leafgarland/typescript-vim'  " TypeScript
let g:syntastic_typescript_checkers = ['tslint']
Plug 'elzr/vim-json'            " JSON Syntax
let g:vim_json_syntax_conceal = 0
" let g:vim_json_warnings       = 0

Plug 'burnettk/vim-angular'     " AngularJS Syntax
Plug 'moll/vim-node'            " NodeJS Syntax
" Plug 'kchmck/vim-coffee-script' " Coffeescript Syntax


" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1

" Plug 'wavded/vim-stylus'    " Stylus

Plug 'chrisbra/Colorizer' " Colors hex value colors
let g:colorizer_auto_map   = 1
let g:colorizer_auto_color = 1

" ## PLUGINS: AUTO COMPLETION
" Plug 'mattn/emmet-vim'      " HTML tag expansion

call plug#end() " Add plugins to &runtimepath - PLUGINS - END


" MISC
colorscheme jellybeans " Required to be placed here from the flazz/vim-colorschemes plugin

set clipboard=unnamed           " Set copy and paste to work with MAC OS clipboard
