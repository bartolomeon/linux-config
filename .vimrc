:syntax on

":filetype plugin indent on

set nocompatible               " be iMproved
filetype off                   " required!


set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
" non github repos
Bundle 'git://git.wincent.com/command-t.git'
" ...
"
Bundle 'jelera/vim-javascript-syntax'
Bundle 'pangloss/vim-javascript'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'Raimondi/delimitMate'
Bundle 'Tagbar'


Bundle 'https://github.com/tpope/vim-pathogen'
Bundle 'https://github.com/kaihendry/vim-html5'


Bundle 'https://github.com/scrooloose/nerdtree'
"Bundle 'https://github.com/Lokaltog/powerline.git'
Bundle 'https://github.com/klen/python-mode.git'
Bundle 'https://github.com/kien/ctrlp.vim.git'

"CtrlP config: (c - current file's dir, r - up to dir containing .git/.svn)
let g:ctrlp_working_path_mode = 'c'
" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>"



filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

" HTML indendantion in Vundle
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

nmap <F8> :TagbarToggle<CR>
map <C-n> :NERDTreeToggle<CR>

execute pathogen#infect()
execute pathogen#helptags()

"set ts=3
set relativenumber

set t_Co=256
let g:solarized_termcolors=256
syntax enable
"colorscheme distinguished
if has('gui_running')
    "colorscheme solarized
    "set background=light
    colorscheme Tomorrow-Night-Eighties
else
    "colorscheme desert256
    colorscheme Tomorrow-Night-Bright
    "set background=dark
endif

" block cursor! (yep)
" disable arrow keys
" map <up> <nop>
" map <down> <nop>
" map <left> <nop>
" map <right> <nop>
" imap <up> <nop>
" imap <down> <nop>
" imap <left> <nop>
" imap <right> <nop>

" run JSHint automatically on each JS file
 "autocmd! BufWritePost *.js JSHint
 "
 autocmd! BufWritePost *.js JSHint
 
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set mouse=a

set hlsearch

" Configure browser for haskell_doc.vim
let g:haddock_browser = "open"
let g:haddock_browser_callformat = "%s %s"


"indend a block of code by <,>
vnoremap < <gv
vnoremap > >gv


"air-line config
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'"


" close a buffer with leader + bq
"nunmap <leader>b
nmap <leader>bq :bp <BAR> bd #<cr>
