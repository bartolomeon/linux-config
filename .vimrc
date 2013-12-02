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
Bundle "pangloss/vim-javascript"
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

set ts=4
set relativenumber


syntax enable
colorscheme solarized
if has('gui_running')
    set background=light
else
    set background=dark
endif

