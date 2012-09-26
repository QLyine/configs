if ($TERM == "rxvt-unicode") && (&termencoding == "")
    set termencoding=utf-8
endif
set encoding=utf-8

if has('gui_running')
"    colorscheme darkc
    colorscheme molokai
"    colorscheme darkspectrum
"    colorscheme candycode
"    colorscheme lucius
"    colorscheme wombat
"    colorscheme nightwish
"    colorscheme zenburn 
"    colorscheme twilight
"    colorscheme tango
    
    set guioptions-=T
    set guioptions-=t
    set guioptions-=m
    set guioptions-=L
    set guioptions-=l
    set guioptions-=r
    set guioptions-=R
    set guifont=Monaco\ 09
"    set guifont=Dina\ 09

else
"    set bg=dark
"    map <F2> :let &background = ( &background == "dark" ? "light" : "dark" )<CR>    
"    color dante
"    colorscheme desert
"    colorscheme neverland
    colorscheme molokai
"    colorscheme zenburn
endif

if &term =~ "xterm\\|rxvt"
    :silent !echo -ne "\033]12;\#B03060\007"
    let &t_SI = "\033]12;orange\007"
    let &t_EI = "\033]12;\#B03060\007"
    autocmd VimLeave * :!echo -ne "\033]12;\#B03060\007"
endif

" Enable filetype plugin
filetype plugin indent on

set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

" turn off the dam annoying beeps
set noerrorbells
set visualbell
set t_vb=

set autoread " auto read when file is changed
set nobackup " I have git...
set nowb
set noswapfile
set magic " magic RE
set mat=2 

set nocp " no-compatible mode
set t_Co=256 " use 256 colors
set undolevels=512 " undo
set showmode " show current mode
set noequalalways " no need to always keep windows same size
set splitbelow " splitted window under current one
set maxfuncdepth=1000 " depth for subs
set wildchar=<Tab> " tab for autocompletion
set wildmode=list:longest,full " bash style completioness
set incsearch " show partial matches
set hlsearch " hilight patterns
set ignorecase " ignore case when searching
set smartcase " ... unless there is capitals in the pattern
set tabstop=2 " tabstop
set expandtab " spaces, not tabs
set shiftwidth=2
set smarttab " outdent by one level using bkspc
set showmatch " show matching brackets etc
set autoindent
set smartindent

set textwidth=80 " be nice!
set nowrap " dont wrap long lines
set number " line numbering
set scrolloff=3 " number of lines to keep above cursor

set number              " show line numbers
set autowrite
set ruler               " ruler display in status line
set cmdheight=1         " command line height
set spelllang=pt

setlocal numberwidth=3
set cursorline                  " hilight line where cursor is

"""""""""""""""""""""""""""""
" => Statusline
" """"""""""""""""""""""""""""""
 " Always hide the statusline
set laststatus=2

 " Format the statusline
set statusline=%<%f\ %h%w%m%r%y%=L:%l/%L\ (%p%%)\ C:%c%V\ B:%o\ F:%{foldlevel('.')}


""""""""""""""""
" Autocommands "
""""""""""""""""

" Clear previous autocmds, stops a few errors creeping in.
autocmd!

" Compile and run keymappings
autocmd FileType c,cpp,ocaml map <F5> :!clear && ./%:r<CR>
autocmd FileType sh,php,perl,python map <F5> :!./%<CR>
autocmd FileType c,cpp map <F6> :make %:r<CR>
autocmd FileType php map <F6> :!php &<CR>
autocmd FileType python map <F6> :!python %<CR>
autocmd FileType perl map <F6> :!perl %<CR>
autocmd FileType html,xhtml map <F5> :!firefox %<CR>
autocmd FileType java map <F6> :!javac %<CR>
autocmd FileType tex map <F5> :!evince "%:r".pdf<CR>
autocmd FileType tex map <F6> :!pdflatex %<CR>

autocmd FileType ocaml map <F6> :!clear && ocamlc % -o "%:r" <CR>

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vim/vimrc
""""""""""""""""""""""""""""
" Map Commands             "
""""""""""""""""""""""""""""
" Move foward and backwards on
" compile warnings/errors
map  <silent> <F7>    <Esc>:cp<CR>
map  <silent> <F8>    <Esc>:cn<CR>
map  <silent> <F9>    <Esc>:set spell<CR>

" open TagList
map  <c-z> <Esc>:TlistOpen<CR>

" open NERDTree
map  <c-t> <Esc>:NERDTree<CR>

" navigate thru tabs
map <c-a> <Esc>:tabp<CR>	
imap <c-a> <Esc>:tabp<CR>	

map <c-s> <Esc>:tabn<CR>	
imap <c-s> <Esc>:tabn<CR>	

""""""""""""""""""""""""""""
" Enable syntax hilighting "
""""""""""""""""""""""""""""
syntax on 

" Default SuperTab Completion
let g:SuperTabDefaultCompletionType = "<c-x><c-u>"  
