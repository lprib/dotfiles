call plug#begin()
    Plug 'morhetz/gruvbox'
    Plug 'rking/ag.vim'
    Plug 'kien/rainbow_parentheses.vim'
    Plug 'preservim/nerdcommenter'
    Plug 'wincent/terminus'
    Plug 'ludovicchabant/vim-lawrencium'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-sleuth'
    Plug 'lervag/vimtex'
    Plug 'junegunn/fzf'
    Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install() } }
call plug#end()

nnoremap <space> <Nop>
let mapleader=" "

set number relativenumber
set splitright splitbelow showcmd noshowmode wildmenu lazyredraw incsearch
set shortmess+=Ic
set diffopt+=vertical
set encoding=utf-8
set cmdheight=2
set scrolloff=2
set inccommand=nosplit
set whichwrap+=h,l

autocmd vimenter * ++nested colorscheme gruvbox

let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 15
noremap <silent> <leader>1 :Lexplore<cr>

" Carry over VSCode muscle memory
noremap <c-s> :w<cr>
nmap <c-_> <leader>c<space>
vmap <c-_> <leader>c<space>gv

map Y y$
nmap \ <c-^>

set ts=4 sw=0

" enable parentheses coloring
autocmd vimenter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces

let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1
" default to // for comments in c
let g:NERDAltDelims_c = 1
let g:NERDAltDelims_java = 1

noremap <silent> <leader>h :nohlsearch<cr>

noremap <silent> <c-p> :FZF -i<cr>
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" recursively search for tags files
set tags=./tag,tags;

" <leader>rc opens the nvim rc file
noremap <leader>rc :tabe ~/.config/nvim/init.vim<cr>
autocmd! BufWritePost init.vim source % | echo "Sourced" expand("%")

" Break out of terminal with escape
tnoremap <esc> <c-\><c-n>

set statusline=
set statusline+=%#TabLineSel#%f
set statusline+=%#TabLine#
set statusline+=%m%w%=
set statusline+=%{&filetype}\ \|\ %L\ lines\ \|\ %l:%c\ 

function! SetupCoc()
    let g:coc_global_extensions = [
        \ 'coc-rust-analyzer',
        \ 'coc-json',
        \ 'coc-tsserver',
        \ 'coc-texlab',
        \ 'coc-sh',
        \ 'coc-pyright',
        \ 'coc-clangd'
    \]

    " CoC configuration
    set hidden nobackup nowritebackup
    set updatetime=300
    set signcolumn=yes

    inoremap <silent><expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
    inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"


    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    " Use `[g` and `]g` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " Formatting selected code.
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current buffer.
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Remap <C-f> and <C-b> for scroll float windows/opups.
    if has('nvim-0.4.0') || has('patch-8.2.0750')
        nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
        nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
        inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
        inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
        vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
        vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    let g:tex_flavor = "latex"

    " map <leader>b to build latex
    augroup latex_build
        autocmd!
        autocmd FileType tex noremap <silent> <leader>b :call CocAction("runCommand", "latex.Build")<cr>
    augroup END
endfunction

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

call SetupCoc()


" Implement Zen mode:

let s:zen_enabled = 0
let s:zen_options_to_save = [
    \ "showmode",
    \ "ruler",
    \ "laststatus",
    \ "showcmd",
    \ "cmdheight",
    \ "showtabline",
    \ "signcolumn",
    \ "number",
    \ "relativenumber"
\]
let s:zen_saved_options = {}

function! ToggleZen()
    if s:zen_enabled == 0
        let s:zen_enabled = 1
        for option_name in s:zen_options_to_save
            execute "let s:zen_saved_options." . option_name . " = &" . option_name
        endfor
        set noshowmode noruler noshowcmd cmdheight=1 laststatus=0 showtabline=0 signcolumn=no nonumber norelativenumber
    else
        let s:zen_enabled = 0
        for [option_name, value] in items(s:zen_saved_options)
            execute "let &" . option_name . " = '" . value . "'"
        endfor
    endif
endfunction

noremap <silent> <leader>z :call ToggleZen()<cr>

" import shortcuts file
runtime shortcuts.vim

function! ShortcutEdit(filename)
    execute "e " . g:my_shortcuts[a:filename]
endfunction

command! -nargs=1 C :call ShortcutEdit("<args>")

