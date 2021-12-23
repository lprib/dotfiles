call plug#begin()
    Plug 'preservim/nerdcommenter'
    Plug 'wincent/terminus'
    Plug 'mhinz/vim-signify'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-sleuth'
    Plug 'lervag/vimtex'
    Plug 'junegunn/fzf'
    Plug 'junegunn/vim-easy-align'

    " theming:
    Plug 'itchyny/lightline.vim'
    Plug 'morhetz/gruvbox'

    Plug 'preservim/nerdtree'
call plug#end()

nnoremap <space> <Nop>
let mapleader=" "

set number relativenumber
set splitright splitbelow showcmd noshowmode wildmenu lazyredraw incsearch
set smartcase
set shortmess+=Ic
set diffopt+=vertical
set encoding=utf-8
set cmdheight=2
set scrolloff=2
set inccommand=nosplit
set whichwrap+=h,l
set clipboard+=unnamedplus
set updatetime=100

set bg=dark
colorscheme gruvbox

nnoremap <leader>rc :e ~/.config/nvim/init.vim<cr>

" generate tags
nnoremap <leader>tg :!ag -l \| ctags -L-

" nvim-tree config:
set termguicolors

noremap <silent> <leader>1 :NERDTreeToggle<cr>

" Signify diff mappings
"
" hunk diffs:
noremap <silent> <leader>d :SignifyHunkDiff<cr>
noremap <silent> <leader>du :SignifyHunkUndo<cr>
" full diff:
noremap <silent> <leader>D :SignifyDiff<cr>

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

" Easy align bindings
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

noremap <silent> <c-p> :FZF -i<cr>
let $FZF_DEFAULT_COMMAND = 'rg --files -g ""'

let g:goyo_width = "95%"
let g:goyo_height = "95%"

" recursively search for tags files
set tags=./tag,tags;

autocmd! BufWritePost init.vim source % | echo "Sourced" expand("%")

" TaitTerminals codebase specifics:
autocmd FileType c,cpp,d,xslt,xml,ruby,sh,python,javascript,html,json,groovy,asm,dot,yaml,markdown autocmd BufWritePre <buffer> %s/\s\+$//e
autocmd FileType c,cpp,d,xslt,xml,ruby,sh,python,javascript,html,json,groovy,dot,yaml,markdown,css set sw=3 sts=3 et sta sr ai si cin cino=>1s(0u0W1s tw=0
autocmd FileType markdown set tw=100 spell
let g:vhdl_indent_genportmap=0
set errorformat^=%*[^:].o:%f:%l:\ %m
set vb

" Break out of terminal with escape
tnoremap <esc> <c-\><c-n>

