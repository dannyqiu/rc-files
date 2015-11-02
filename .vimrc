set nocompatible
filetype off 

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'othree/html5.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'groenewege/vim-less'
Plugin 'tpope/vim-liquid'
Plugin 'tpope/vim-surround'
Plugin 'Valloric/YouCompleteMe'
call vundle#end()

filetype plugin indent on

" Use tabs instead of spaces for Makefile
if @% != 'Makefile'
   set softtabstop=4
   set shiftwidth=4
   set expandtab
endif

set si
set autoindent
set smartindent
set number
syntax on
set synmaxcol=356

set hlsearch " Highlight searches
set ignorecase " Ignore case in searches

set cursorline
highlight Cursorline cterm=none ctermbg=250
autocmd InsertEnter * highlight Cursorline cterm=none ctermbg=black
autocmd InsertLeave * highlight Cursorline cterm=none ctermbg=250

" Only highlight to a certain length
let g:LineLength_LineLength = 534 " Width of screen (178) x 3
"let g:LineLength_ctermbg = 0

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
MapToggle <C-e> spell
" Use w!! to write if file requires sudo permissions
cmap w!! w !sudo tee > /dev/null %
