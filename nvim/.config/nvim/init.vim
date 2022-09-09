set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'scrooloose/nerdtree'
Plugin 'plasticboy/vim-markdown'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'kien/ctrlp.vim'
Plugin 'joom/latex-unicoder.vim'
Plugin 'vim-python/python-syntax'
Plugin 'JuliaEditorSupport/julia-vim'
call vundle#end()

filetype plugin indent on

scriptencoding utf-8
set encoding=utf-8
set nocompatible
set autoindent
set backup
set nu
set smartindent
set showmatch
set textwidth=0
set wrapmargin=0
set title
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set cursorline

syntax on
set t_Co=256
filetype indent on
filetype plugin on
set ls=2
set background=dark
colorscheme PaperColor

set guicursor+=n-v-c:blinkon0
set incsearch
set backupdir=~/.vimtmp,.
set directory=~/.vimtmp,.
set wrap
set backspace=2
set backspace=indent,eol,start
set wildmode=longest,list,full
set wildmenu
set breakindent
" no jump on first *
nnoremap * *``

" fix nerdtree arrows
command NT NERDTreeToggle
command NTF NERDTreeFind
let g:NERDTreeDirArrows=1
let NERDTreeRespectWildIgnore=1
let NERDTreeIgnore = ['\.pyc$']

au Filetype python setl et ts=4 sw=4 nosmartindent

" julia
au Filetype julia setl et ts=4 sw=4 nosmartindent
au BufNewFile,BufFilePre,BufRead *.jl set filetype=julia

" ROS launch
au BufNewFile,BufFilePre,BufRead *.launch set filetype=xml

" markdown
au Filetype markdown setl et ts=4 sw=4 nosmartindent
autocmd FileType markdown nnoremap ,p :!orig=% && fnd=".md" && rpl=".pdf" && bib=".bib" &&
            \ new_path="${orig/$fnd/$rpl}" && bib_path="${orig/$fnd/$bib}" &&
            \ pandoc --filter pandoc-citeproc --variable classoption=onecolumn
                \ --variable papersize=a4paper -V geometry:margin=1in % -o $new_path &&
            \ echo "Displaying $new_path with evince..." && evince $new_path &> /dev/null <cr>

au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
au BufNewFile,BufFilePre,BufRead readme* set filetype=markdown
let g:vim_markdown_folding_disabled = 1

" C
au Filetype c setl et ts=2 sw=2

" Arduino
autocmd FileType arduino nnoremap ,t :!make clean -C %:p:h && clear && make -C %:p:h<cr>
autocmd FileType arduino nnoremap ,T :!make clean -C %:p:h && clear && make upload -C %:p:h<cr>

" LaTeX
autocmd FileType tex nnoremap ,p :!orig=% && fnd=".tex" && rpl=".pdf" &&
            \ new_path="${orig/$fnd/$rpl}" &&
            \ pdflatex % -o $new_path &&
            \ echo "Displaying $new_path with evince..." && evince $new_path &> /dev/null <cr>

" yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" lua
au Filetype lua setl et ts=2 sw=2

augroup filetypedetect
    au BufRead,BufNewFile *.ex set filetype=erlang
augroup END

" for copy-paste to clipboard
set clipboard=

" persistent undo
if has("persistent_undo")
  set undodir=~/.undodir/
  set undofile
endif

" display user inputs in bottom-right
set showcmd

function VCopy() range "Visual Copy
  '<,'>y
  call writefile(split(@@, "\n", 1), 'temp_xclip_file.tmp')
  silent exec "!xclip -sel clip < 'temp_xclip_file.tmp'"
  silent exec "!rm 'temp_xclip_file.tmp'"
  redraw!
  echom "Selected lines copied to system clipboard"
endfunction
vnoremap <LocalLeader>VC :call VisCpy()<cr>

function Ftabs() "convert tabs to spaces
  set expandtab
  retab
endfunction

" highlight search on by default
set hls

:nnoremap <CR> :nohlsearch<cr>
nnoremap <leader><leader> <c-^>

" Show trailing whitepace and spaces before a tab:
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
" Remove all trailing whitespace on write
autocmd BufWritePre * %s/\s\+$//e

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.pdf,*__pycache__*
let g:ctrlp_custom_ignore = '\v[\/](build)|(\.(git|hg|svn))$'
let g:ctrlp_map = '<c-p>'

augroup vimrcEx
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g'\"" |
        \ endif
augroup END

" Disable ctrl+a number incrementing (dangerous when ctrl+a is tmux binding)
map <C-a> <Nop>

" enable plugin 'vim-python/python-syntax'
let g:python_highlight_all = 1

let mapleader = " "
nnoremap Y yg$
nnoremap n nzzzv
nnoremap N Nzzzv

xnoremap <leader>p "_dP
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
nnoremap <leader>d "_d
vnoremap <leader>d "_d
