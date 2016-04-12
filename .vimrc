set nocompatible
filetype off 

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'hdima/python-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'justinmk/vim-syntax-extra'
Plugin 'kchmck/vim-coffee-script'
Plugin 'othree/html5.vim'
Plugin 'groenewege/vim-less'
Plugin 'tpope/vim-liquid'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/DrawIt'
Plugin 'Valloric/YouCompleteMe'
call vundle#end()

filetype plugin indent on

" Use tabs instead of spaces for Makefile
if @% != 'Makefile'
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set expandtab
endif

set si
set autoindent
set smartindent
set number
set mouse=a " Mouse does not select line numbers
syntax on
set synmaxcol=356

set hlsearch " Highlight searches
set ignorecase " Ignore case in searches

highlight Comment ctermfg=darkgrey
set cursorline
highlight Cursorline cterm=none ctermbg=236
autocmd InsertEnter * highlight Cursorline cterm=none ctermbg=None
autocmd InsertLeave * highlight Cursorline cterm=none ctermbg=236
" highlight Cursorline cterm=none ctermbg=white
" autocmd InsertLeave * highlight Cursorline cterm=none ctermbg=white

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Fix problem with backspace key
set backspace=indent,eol,start

" Map key to toggle opt
function MapToggle(key, opt)
    let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
    exec 'nnoremap '.a:key.' '.cmd
    exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command -nargs=+ MapToggle call MapToggle(<f-args>)

" Key Mappings
" Prevent Ex Mode
map Q <Nop>
imap <C-c> <Esc>
MapToggle <C-e> spell
" Use w!! to write if file requires sudo permissions
cmap w!! w !sudo tee > /dev/null %

let python_highlight_all = 1
let javascript_enable_domhtmlcss = 1
