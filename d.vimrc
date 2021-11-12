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

" Import local config
source ~/.vimrc.local
