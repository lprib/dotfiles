call plug#begin()
    Plug 'rking/ag.vim'
    Plug 'preservim/nerdcommenter'
    Plug 'wincent/terminus'
    Plug 'ludovicchabant/vim-lawrencium'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-sleuth'
    Plug 'lervag/vimtex'
    Plug 'junegunn/fzf'
    " Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install() } }

    " theming:
    Plug 'kyazdani42/nvim-web-devicons' " for file icons
    Plug 'itchyny/lightline.vim'
    Plug 'morhetz/gruvbox'
    " Plug 'kien/rainbow_parentheses.vim'

    Plug 'preservim/nerdtree'

    Plug 'junegunn/goyo.vim'
    Plug 'dense-analysis/ale'
call plug#end()

nnoremap <space> <Nop>
let mapleader=" "

set number relativenumber
set splitright splitbelow showcmd noshowmode wildmenu lazyredraw incsearch
set ignorecase smartcase
set shortmess+=Ic
set diffopt+=vertical
set encoding=utf-8
set cmdheight=2
set scrolloff=2
set inccommand=nosplit
set whichwrap+=h,l

set bg=dark
colorscheme gruvbox

nnoremap <leader>rc :e ~/.config/nvim/init.vim<cr>

" generate tags
nnoremap <leader>tg :!ag -l \| ctags -L-

" nvim-tree config:
set termguicolors

noremap <silent> <leader>1 :NERDTreeToggle<cr>

" Carry over VSCode muscle memory
noremap <c-s> :w<cr>
nmap <c-_> <leader>c<space>
vmap <c-_> <leader>c<space>gv
nmap <c-a> ggVG

map Y y$
nmap \ <c-^>

" Control backspace deletes word in insert mode:
imap <c-H> <c-W>

set ts=4 sw=0

let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1
" default to // for comments in c
let g:NERDAltDelims_c = 1
let g:NERDAltDelims_java = 1

noremap <silent> <leader>h :nohlsearch<cr>

noremap <silent> <c-p> :FZF -i<cr>
let $FZF_DEFAULT_COMMAND = 'rg --files -g ""'

let g:goyo_width = "95%"
let g:goyo_height = "95%"

noremap <silent> <leader>z :Goyo<cr>

" recursively search for tags files
set tags=./tag,tags;

autocmd! BufWritePost init.vim source % | echo "Sourced" expand("%")

" Break out of terminal with escape
tnoremap <esc> <c-\><c-n>

