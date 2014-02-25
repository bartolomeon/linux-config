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

let g:solarized_termcolors=256

syntax enable
"colorscheme distinguished
colorscheme solarized
if has('gui_running')
    set background=light
else
    set background=dark
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
 
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

