function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin()
    Plug 'junegunn/fzf'
    Plug 'preservim/nerdcommenter'
    Plug 'tpope/vim-sleuth'
    Plug 'rking/ag.vim', Cond(!exists('g:vscode'))
    Plug 'wincent/terminus', Cond(!exists('g:vscode'))
    Plug 'ludovicchabant/vim-lawrencium', Cond(!exists('g:vscode'))
    Plug 'tpope/vim-fugitive', Cond(!exists('g:vscode'))
    Plug 'lervag/vimtex', Cond(!exists('g:vscode'))

    Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install() } }
    Plug 'jackguo380/vim-lsp-cxx-highlight', Cond(!exists('g:vscode'))
    Plug 'tikhomirov/vim-glsl', Cond(!exists('g:vscode'))
    Plug 'cespare/vim-toml', Cond(!exists('g:vscode'))
    Plug 'sophacles/vim-processing', Cond(!exists('g:vscode'))
    Plug 'rust-lang/rust.vim', Cond(!exists('g:vscode'))

    " theming:
    Plug 'kyazdani42/nvim-web-devicons', Cond(!exists('g:vscode'))
    Plug 'itchyny/lightline.vim', Cond(!exists('g:vscode'))
    Plug 'morhetz/gruvbox', Cond(!exists('g:vscode'))

    Plug 'junegunn/goyo.vim', Cond(!exists('g:vscode'))
    Plug 'kyazdani42/nvim-tree.lua', Cond(!exists('g:vscode'))
call plug#end()


nnoremap <space> <Nop>
let mapleader=" "

set number relativenumber
set ignorecase smartcase
set splitright splitbelow showcmd noshowmode wildmenu lazyredraw incsearch
set shortmess+=Ic
set diffopt+=vertical
set encoding=utf-8
set cmdheight=2
set scrolloff=2
set inccommand=nosplit
set whichwrap+=h,l



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

" Make vim respect terminal transparency
autocmd ColorScheme * hi Normal guibg=NONE ctermbg=None
autocmd vimenter * ++nested colorscheme gruvbox

if !exists('g:vscode')
    " nvim-tree config:
    noremap <silent> <leader>1 :NvimTreeToggle<cr>
    let g:nvim_tree_auto_open = 1
    let g:nvim_tree_auto_close = 1
    let g:nvim_tree_follow = 1
    let g:nvim_tree_git_hl = 1

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
endif

" recursively search for tags files
set tags=./tag,tags;

autocmd! BufWritePost init.vim source % | echo "Sourced" expand("%")

" Break out of terminal with escape
tnoremap <esc> <c-\><c-n>

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

    imap <c-h> <esc>:call CocActionAsync('showSignatureHelp')<cr>i

    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    " nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current buffer.
    nmap <leader>ba  <Plug>(coc-codeaction)
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
        autocmd FileType tex noremap <leader>b :w \| call CocAction("runCommand", "latex.Build")<cr>
    augroup END

    augroup rust_keybinds
        autocmd!
        autocmd FileType rust noremap <leader>ma :call CocAction('runCommand', 'rust-analyzer.expandMacro')<cr>
        autocmd FileType rust noremap <leader>K :call CocAction('runCommand', 'rust-analyzer.openDocs')<cr>
        autocmd FileType rust noremap <leader>t :call CocAction('runCommand', 'rust-analyzer.toggleInlayHints')<cr>
    augroup END

    " lightline integration
    let g:lightline = {
          \ 'colorscheme': 'wombat',
          \ 'active': {
          \   'left': [ [ 'mode', 'paste' ],
          \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
          \ },
          \ 'component_function': {
          \   'cocstatus': 'coc#status',
          \   'currentfunction': 'CocCurrentFunction'
          \ },
          \ }
endfunction

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
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

if !exists('g:vscode')
    call SetupCoc()

    " import shortcuts file
    runtime shortcuts.vim

    function! ShortcutEdit(filename)
        execute "e " . g:my_shortcuts[a:filename]
    endfunction

    command! -nargs=1 C :call ShortcutEdit("<args>")
endif


