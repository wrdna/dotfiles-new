
" Don't try to be vi compatible
set nocompatible

" Change runtime path to include mount location
set runtimepath+=~/mnt/.config/.vim/

" Show line numbers
set number

" Show file stats
set ruler

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Blink cursor on error instead of beeping (grr)
" set visualbell

" Encoding
set encoding=utf-8

"activates filetype detection
filetype plugin indent on

" activates syntax highlighting among other things
syntax on

" allows you to deal with multiple unsaved
" buffers simultaneously without resorting
" to misusing tabs
set hidden

" just hit backspace without this one and
" see for yourself... idk if this does anything
set backspace=indent,eol,start

" Undo history
if has('persistent_undo')      "check if your vim version supports it
    set undofile                 "turn on the feature  
    set undodir=$HOME/mnt/.config/.vim/undo  "directory where the undo files will be stored
endif   

" autocmd InsertEnter,InsertLeave * set cul!
set number relativenumber
set title
set hidden          " opening new file hides current instead of closing
set nowrap          " switch off line wrapping
set tabstop=4       " Set tabs to 4 characaters wide
set shiftwidth=4    " Set indentation width to match tab
set expandtab       " Use spaces instead of actual hard tabs
set softtabstop=4   " Set the soft tab to match the hard tab width
set backspace=indent,eol,start  " Make bs work across line breaks etc
set autoindent      " Enable basic auto indentation
set scrolloff=8     " Keep cursor within middle of screen 
set copyindent      " Preserve manual indentation

" Colors
set background=dark
colorscheme monokai
" highlight Normal ctermfg=grey ctermbg=darkblue
set cursorline
hi CursorLine term=bold cterm=bold

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Change cursor on insert mode
" https://stackoverflow.com/questions/6488683/how-to-change-the-cursor-between-normal-and-insert-modes-in-vim

" Other options (replace the number after \e[):
" Ps = 0  -> blinking block.
" Ps = 1  -> blinking block (default).
" Ps = 2  -> steady block.
" Ps = 3  -> blinking underline.
" Ps = 4  -> steady underline.
" Ps = 5  -> blinking bar (xterm).
" Ps = 6  -> steady bar (xterm).

let &t_SI = "\e[5 q"
let &t_SR = "\e[3 q"
let &t_EI = "\e[2 q"

" reset the cursor on start (for older versions of vim, usually not required)
" augroup myCmds
" au!
" autocmd VimEnter * silent !echo -ne "\e[2 q"
" augroup END
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader=" "

" Toggle netrw
source /home/$USER/.vim/plugins/explorer.vim
nmap <leader>e <Plug>ToggleLex
" autocmd FileType netrw autocmd BufLeave <buffer> if &filetype == 'netrw' | :bd | :e | endif

" Load vimrc"
nmap <leader>so :source ~/mnt/.config/.vim/.vimrc<CR>

" Quit"
nmap <leader>pv :q<CR>

" nnoremap <leader>fh :buffers<CR>"
nnoremap <leader>fh :buffers<CR>:buffer<Space>
nnoremap <leader>ff :find<Space>./

map <leader>n :bnext<CR>
map <leader>b :bprevious<CR>
map <leader>d :bdelete<CR>

" cnoreabbrev <expr> w getcmdtype() == ":" && getcmdline() == "w" ? "checktime | w" : "w"
