scriptencoding utf-8
set encoding=utf-8
set showcmd
set showmatch
set smartcase
set mouse=a
set ttymouse=xterm2
set nocompatible
set title
syntax on
filetype plugin indent on
set wrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround
set scrolloff=5
set backspace=indent,eol,start
set ttyfast
set laststatus=2
set showmode
set showcmd
set matchpairs+=<:>
set list
set listchars=tab:»\ ,trail:·,extends:#,nbsp:.
set showbreak=+++\\\ 
set number
set t_Co=256
set cursorline
set hlsearch
set viminfo='100,<9999,s100
set smartindent
set ruler
set langmap=ㅁa,ㅠb,ㅊc,ㅇd,ㄷe,ㄹf,ㅎg,ㅗh,ㅑi,ㅓj,ㅏk,ㅣl,ㅡm,ㅜn,ㅐo,ㅔp,ㅂq,ㄱr,ㄴs,ㅅt,ㅕu,ㅍv,ㅈw,ㅌx,ㅛy,ㅋz
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" True Color
set termguicolors
" Fix True Color - See: https://stackoverflow.com/questions/62702766/termguicolors-in-vim-makes-everything-black-and-white
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Settings By OS
"   (https://stackoverflow.com/questions/2842078/how-do-i-detect-os-x-in-my-vimrc-file-so-certain-configurations-will-only-appl)
if has("macunix")
  " Mac
  set clipboard=unnamed
elseif has("unix")
  " Linux
  set clipboard=unnamedplus
elseif has("win32") || has("win64")
  " Win32/64
elseif has("win32unix")
  " Win32/64 Unix
else
  echo "Unknown GUI system!!!!"
endif

" Import local config
source ~/.vimrc.local

