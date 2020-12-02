set nocompatible

function! SetupYCM(info)
    !./install.py --clangd-completer --js-completer

    " from https://github.com/ycm-core/YouCompleteMe#option-2-provide-the-flags-manually
    let my_ycm_extra_conf_file = $HOME . "/.vim/.my_ycm_extra_conf.py"
    call writefile(["def Settings( **kwargs ):"], my_ycm_extra_conf_file)
    call writefile(["  return { 'flags': [ '-x', 'c++', '-Wall', '-Wextra', '-Werror' ] }"], my_ycm_extra_conf_file, 'a')
endfun

call plug#begin()
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
Plug 'pedrohdz/vim-yaml-folds', { 'for': 'yaml' }
Plug 'tpope/vim-markdown', {'for': 'md'}
Plug 'darfink/vim-plist'
Plug 'tpope/vim-surround'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/DrawIt'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
if has('mac')
    Plug 'Valloric/YouCompleteMe', { 'do': function('SetupYCM') }
endif
call plug#end()

set ttyfast         " Enable on fast terminal connection (local)
set lazyredraw      " Buffer redraws
set noerrorbells    " Disable annoying error tone
set novisualbell    " Disable annoying visual error
"set belloff=all     " Actually disable bell tone

set laststatus=2    " Show status line on all windows, not just on splits
set wildmenu        " Autocompletion menu
set wildignore=*.o,*~,*.pyc,*.class,*.byte " Ignore compiled files

set backspace=indent,eol,start " Fix problem with backspace key
set mouse=a         " Allow using mouse

set number          " Show line numbers
set scrolloff=3     " Start scrolling before the reaching borders

set autoindent      " Enable auto-indenting
set smartindent     " Indent based on syntax
set tabstop=4       " Tab size
set softtabstop=4   " Tabs as spaces
set shiftwidth=4    " Automatic indent
set expandtab       " Use spaces instead of tabs

syntax on           " Enable syntax hightlighting
set synmaxcol=356   " Maximum number of characters per line to highlight

set incsearch       " Search while typing
set hlsearch        " Highlight searches
set ignorecase      " Ignore case in searches
set wrapscan        " Automatically search from bottom once bottom is reached

colorscheme default " Use default colors

set cursorline      " Highlight current line
highlight Comment ctermfg=DarkGrey
highlight CursorLine cterm=none ctermfg=none ctermbg=none
highlight LineNr cterm=none ctermfg=Brown ctermbg=none
highlight CursorLineNr cterm=none ctermfg=Cyan ctermbg=none
highlight Pmenu cterm=none ctermfg=15 ctermbg=52
highlight PmenuSel cterm=bold ctermfg=255 ctermbg=234

" Map key to toggle opt
function! MapToggle(key, opt)
    let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
    exec 'nnoremap '.a:key.' '.cmd
    exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command! -nargs=+ MapToggle call MapToggle(<f-args>)

" Key Mappings
" ==================
set timeoutlen=1000 " Set mapping delay timeout
set ttimeoutlen=0   " Set key code delay timeout
" Prevent Ex Mode
map Q <Nop>
" Make it easier on the fingers
inoremap <C-c> <Esc>
" Spell check in one keystroke
MapToggle <leader>ss spell
" Paste mode in one keystroke
MapToggle <leader>pp paste
" Abbreviations for typos
cnoreabbrev Wq wq
cnoreabbrev wQ wq
" Keep visual selection when (un)indenting
vnoremap < <gv
vnoremap > >gv

" Use w!! to write if file requires sudo permissions
cmap w!! w !sudo tee > /dev/null %

" ======== file specific ========
" Disable cursorline in vim script because regexes are slow
augroup ft_vim
    autocmd!
    autocmd FileType vim setlocal nocursorline
augroup END

augroup ft_zsh
    autocmd!
    autocmd FileType zsh setlocal nocursorline
augroup END

" Use tabs instead of spaces for Makefile
augroup ft_make
    autocmd!
    autocmd FileType make setlocal ts=8 sts=0 sw=8 noexpandtab
augroup END

" Use two spaces in yaml files
augroup ft_yaml
    autocmd!
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2
augroup END

" python support
augroup ft_python
    let python_highlight_all = 1
    let g:virtualenv_auto_activate = 1
augroup END

" javascript support
augroup ft_javascript
    let javascript_enable_domhtmlcss = 1
augroup END

" java support
augroup ft_java
    autocmd!
    autocmd Filetype pde syntax=java
    let java_comment_strings=1
    let java_highlight_java_lang_ids=1
    let java_mark_braces_in_parens_as_errors=1
    let java_highlight_all=1
    let java_highlight_debug=1
    let java_ignore_javadoc=1
    let java_highlight_java_lang_ids=1
    let java_highlight_functions="style"
    let java_minlines = 150
augroup END

" ocaml support
function! OcamlHelper()
    let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
    execute "set rtp+=" . g:opamshare . "/merlin/vim"
    setlocal ts=2 sts=2 sw=2 tw=80 cc=80
endfunction

augroup ft_ocaml
    autocmd!
    autocmd FileType ocaml call OcamlHelper()
augroup END

" ruby support
augroup ft_ruby
    autocmd!
    autocmd FileType ruby setlocal ts=2 sts=2 sw=2
augroup END

" mac plist support
augroup ft_plist
    let g:plist_display_format = 'xml'
    let g:plist_save_format = 'binary'
augroup END

" Use tabs instead of spaces for xml
augroup ft_xml
    autocmd!
    autocmd FileType xml setlocal ts=4 sts=0 sw=4 noexpandtab
augroup END

augroup ft_flex
    autocmd!
    autocmd FileType flex setlocal ts=2 sts=2 sw=2
augroup END

augroup ft_tex
    autocmd!
    autocmd FileType tex setlocal ts=2 sts=2 sw=2 nocursorline
augroup END

" for you-complete-me
let g:ycm_global_ycm_extra_conf = $HOME . '/.vim/.my_ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_python_binary_path = 'python3'
let g:ycm_disable_for_files_larger_than_kb = 1000
let g:ycm_seed_identifiers_with_syntax = 1
highlight YcmErrorSection ctermfg=15 ctermbg=88
highlight YcmWarningSign ctermfg=15 ctermbg=95
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" for large files
let g:airline_extensions = []
let g:LargeFile = 10 * 1024 * 1024
augroup LargeFile
    autocmd!
    autocmd BufReadPre * let f=expand("<afile>") |
                \ if getfsize(f) > g:LargeFile |
                \ set eventignore+=FileType |
                \ setlocal noswapfile bufhidden=unload undolevels=10 |
                \ endif
augroup END
