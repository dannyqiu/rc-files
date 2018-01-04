set nocompatible
filetype off

call plug#begin()
Plug 'gmarik/Vundle.vim'
Plug 'hdima/python-syntax'
Plug 'vim-scripts/indentpython.vim'
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
Plug 'vim-jp/vim-java'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'justinmk/vim-syntax-extra'
Plug 'let-def/ocp-indent-vim'
Plug 'othree/html5.vim'
Plug 'leshill/vim-json'
Plug 'groenewege/vim-less'
Plug 'tpope/vim-liquid'
Plug 'tpope/vim-surround'
Plug 'bronson/vim-trailing-whitespace'
Plug 'vim-scripts/DrawIt'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Valloric/YouCompleteMe'
call plug#end()

filetype plugin indent on

set wildmenu
set wildignore="*.o,*~,*.pyc,*.class,*.byte"

set autoindent
set smartindent
set number
set mouse=a " Mouse does not select line numbers
syntax on
set synmaxcol=356

set incsearch " Search while typing
set hlsearch " Highlight searches
set ignorecase " Ignore case in searches

highlight Comment ctermfg=DarkGrey
set cursorline
" highlight Cursorline cterm=none ctermbg=236
" autocmd InsertEnter * highlight Cursorline cterm=none ctermbg=None
" autocmd InsertLeave * highlight Cursorline cterm=none ctermbg=236
highlight CursorLine cterm=none ctermfg=none ctermbg=none
highlight LineNr cterm=none ctermfg=Brown ctermbg=none
highlight CursorLineNr cterm=none ctermfg=Cyan ctermbg=none

set ttyfast
set lazyredraw

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Fix problem with backspace key
set backspace=indent,eol,start

" Show status line on all windows, not just on splits
set laststatus=2

" Map key to toggle opt
function MapToggle(key, opt)
    let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
    exec 'nnoremap '.a:key.' '.cmd
    exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command -nargs=+ MapToggle call MapToggle(<f-args>)

" Key Mappings
" ==================
let mapleader = "\<Space>"
" Prevent Ex Mode
map Q <Nop>
" Make it easier on the fingers
imap <C-c> <Esc>
MapToggle <C-e> spell
" Abbreviations for typos
cnoreabbrev Wq wq
cnoreabbrev wQ wq

" Use w!! to write if file requires sudo permissions
cmap w!! w !sudo tee > /dev/null %

" ======== file specific ========

" Use tabs instead of spaces for Makefile
if @% != 'Makefile'
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set expandtab
endif

" Use two spaces in yaml files
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" python support
let python_highlight_all = 1
let g:virtualenv_auto_activate = 1

" javascript support
let javascript_enable_domhtmlcss = 1

" ocaml support
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
set rtp+=~/.vim/bundle/ocp-indent-vim
autocmd FileType ocaml setlocal ts=2 sts=2 sw=2 tw=80 cc=80 expandtab

" ruby support
autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab

" For you-complete-me
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
augroup load_ycm
  autocmd!
  autocmd CursorHold, CursorHoldI * :packadd YouCompleteMe
                                \ | autocmd! load_ycm
augroup END
let g:ycm_python_binary_path = 'python3'
let g:ycm_disable_for_files_larger_than_kb = 1000
let g:ycm_confirm_extra_conf = 0
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
