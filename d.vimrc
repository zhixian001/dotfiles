scriptencoding utf-8
set encoding=utf-8
set showcmd
set showmatch
set smartcase
set mouse=a
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

" Keymaps
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" KeyMap -> VSCode

" K.Panes: Switch
noremap <C-K>h <C-W>h
noremap <C-K>j <C-W>j
noremap <C-K>k <C-W>k
noremap <C-K>l <C-W>l
noremap <C-W>h <Nop>
noremap <C-W>j <Nop>
noremap <C-W>k <Nop>
noremap <C-W>l <Nop>
noremap <C-W-H> <Nop>
noremap <C-W-J> <Nop>
noremap <C-W-K> <Nop>
noremap <C-W-L> <Nop>

" Autocomplete
function! Auto_complete_string()                               
    if pumvisible()                                            
        return "\<C-n>"                                        
    else                                                       
        return "\<C-x>\<C-o>\<C-r>=Auto_complete_opened()\<CR>"
    end                                                        
endfunction                                                    

function! Auto_complete_opened()                               
    if pumvisible()                                            
        return "\<c-n>\<c-p>\<c-n>"                            
    else                                                       
        return "\<bs>\<C-n>"                                   
    end                                                        
endfunction                                                    

inoremap <expr> <Nul> Auto_complete_string()