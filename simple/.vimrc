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

" Key Mappings
" Prevent Ex Mode
map Q <Nop>
" Use w!! to write if file requires sudo permissions
cmap w!! w !sudo tee > /dev/null %
