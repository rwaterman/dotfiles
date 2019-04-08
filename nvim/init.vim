" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'w0rp/ale'
call plug#end()

" ALE asynchronous linter
" clear all fixers and linters
let g:ale_fixers = {}
let g:ale_linters = {}
let g:ale_fixers['javascript'] = ['eslint']
let g:ale_fixers['typescript'] = ['tslint']
let g:ale_fixers['python'] = ['autopep8']
let g:ale_fixers['rust'] = ['rustc']

" Lightline
let g:lightline = { 'colorscheme': 'one' }

if (has("termguicolors"))
  set termguicolors
endif

" Spaces & Tabs {{{
set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set shiftwidth=2    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line
" }}} Spaces & Tabs
map ; :FZF<CR>
