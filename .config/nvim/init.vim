call plug#begin()
    Plug 'preservim/nerdcommenter'
    Plug 'wincent/terminus'
    Plug 'mhinz/vim-signify'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-sleuth'
    Plug 'lervag/vimtex'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/vim-easy-align'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " theming:
    Plug 'itchyny/lightline.vim'
    Plug 'joshdick/onedark.vim'

    Plug 'preservim/nerdtree'
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
set clipboard+=unnamedplus
set updatetime=100
set nuw=5



" syntax on
colorscheme onedark

nnoremap <leader>rc :e ~/.config/nvim/init.vim<cr>

" generate tags
nnoremap <leader>tg :!ag -l \| ctags -L-

" nvim-tree config:
set termguicolors

noremap <silent> <leader>1 :NERDTreeToggle<cr>

" Signify diff mappings

" hunk diffs:
noremap <silent> <leader>d :SignifyHunkDiff<cr>
noremap <silent> <leader>ud :SignifyHunkUndo<cr>
" full diff:
noremap <silent> <leader>D :SignifyDiff<cr>
let g:signify_sign_change_delete = '-'

" Carry over VSCode muscle memory
noremap <c-s> :w<cr>
nmap <c-_> <leader>c<space>
vmap <c-_> <leader>c<space>gv
nmap <c-a> ggVG

" make pasting not overwrite copy register
xnoremap p pgvy

" <leader>pa copies path to clipboard
" <leader>pf copies full path to clipboard
nmap <leader>pa :let @+=expand("%")<cr>
nmap <leader>pf :let @+=expand("%:p")<cr>

map Y y$
nmap \ <c-^>

" Control backspace deletes word in insert mode:
imap <c-H> <c-W>


" Custom Grep command:
set grepprg=ag\ --vimgrep

function! Grep(...)
	return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

augroup quickfix
	autocmd!
	autocmd QuickFixCmdPost cgetexpr cwindow
	autocmd QuickFixCmdPost lgetexpr lwindow
augroup END

" search (loc list by default)
nnoremap <leader>s "syiw:LGrep -s <c-r>s<cr>
vnoremap <leader>s "sy:LGrep -s <c-r>s<cr>

" quickfix search
nnoremap <leader>qs "syiw:Grep -s <c-r>s<cr>
vnoremap <leader>qs "sy:Grep -s <c-r>s<cr>

" C file search (loc list)
nnoremap <leader>cs "syiw:LGrep --cc -s <c-r>s<cr>
vnoremap <leader>cs "sy:LGrep --cc -s <c-r>s<cr>

" quickfix C search
nnoremap <leader>qcs "syiw:Grep --cc -s <c-r>s<cr>
vnoremap <leader>qcs "sy:Grep --cc -s <c-r>s<cr>

"location list jumping
nnoremap ) :lnext<cr>
nnoremap ( :lprev<cr>


nnoremap g) :cn<cr>
nnoremap g( :cp<cr>

" set ts=4 sw=0

let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1
" default to // for comments in c
let g:NERDAltDelims_c = 1
let g:NERDAltDelims_java = 1

noremap <silent> <leader>h :nohl<cr>:ccl<cr>:lcl<cr>

" Easy align bindings
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

noremap <silent> <c-p> :FZF -i<cr>
let $FZF_DEFAULT_COMMAND = 'ag -l'
let g:fzf_tags_command = 'ctags -R'

let g:goyo_width = "95%"
let g:goyo_height = "95%"

" recursively search for tags files
set tags=./tag,tags;

autocmd! BufWritePost init.vim source % | echo "Sourced" expand("%")

" TaitTerminals codebase specifics:
autocmd FileType c,cpp,d,xslt,xml,ruby,sh,python,javascript,html,json,groovy,asm,dot,yaml,markdown autocmd BufWritePre <buffer> %s/\s\+$//e
autocmd FileType c,cpp,d,xslt,xml,ruby,sh,python,javascript,html,json,groovy,dot,yaml,markdown,css set sw=3 sts=3 et sta sr ai si cin cino=>1s(0u0W1s tw=0
let g:vhdl_indent_genportmap=0
set errorformat^=%*[^:].o:%f:%l:\ %m
set vb

" Break out of terminal with escape
tnoremap <esc> <c-\><c-n>

" Tree-sitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

