set tabstop=4
set autoindent
set expandtab
set shiftwidth=4
set laststatus=2
set ignorecase
set smartcase
" set mouse=a
set nu
set visualbell
set hlsearch
set wildmenu
set showmatch
set wrapscan
set backspace=indent,eol,start
" html, js indent
autocmd! FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd! FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

hi Comment ctermfg=1

set nocompatible
filetype off

if has('vim_starting')
    set runtimepath+=/usr/local/neobundle.vim
    call neobundle#rc(expand('~/.vim/'))
endif

NeoBundle 'The-NERD-tree'
NeoBundle 'lambdalisue/vim-python-virtualenv'
NeoBundle 'mitechie/pyflakes-pathogen'
NeoBundle 'reinh/vim-makegreen'
NeoBundle 'lambdalisue/nose.vim'
NeoBundle 'sontek/rope-vim'
NeoBundle 'git://github.com/vim-scripts/pythoncomplete.git'
NeoBundle 'JavaScript-syntax'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'myhere/vim-nodejs-complete'
" web開発系
NeoBundle 'mattn/emmet-vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tell-k/vim-browsereload-mac'
NeoBundle 'othree/html5.vim'
NeoBundle 'hail2u/vim-css3-syntax'
" angular syntax
NeoBundle 'othree/javascript-libraries-syntax.vim'
" power line
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'stephenmckinney/vim-solarized-powerline'
" C++
NeoBundle 'Rip-Rip/clang_complete'

nmap <Leader>n : NERDTreeToggle<CR>

highlight SpellBad cterm=NONE ctermfg=white ctermbg=black

" neocomplcache, neocomplete
function! s:meet_neocomplete_requirements()
    return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction

if s:meet_neocomplete_requirements()
    NeoBundle 'Shougo/neocomplete.vim'
    NeoBundleFetch 'Shougo/neocomplcache.vim'
else
    NeoBundleFetch 'Shougo/neocomplete.vim'
    NeoBundle 'Shougo/neocomplcache.vim'
endif

if s:meet_neocomplete_requirements()
    "新しい設定
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#min_keyword_length = 3
else
    " 今までの設定
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_min_syntax_length = 3
    let g:neocomplcache_force_overwrite_completefunc = 1

    inoremap <expr><C-g> neocomplcache#undo_completion()
    inoremap <expr><C-l> neocomplcache#complete_common_string()
    " Recommended key-mappings
    " <CR>: close popup and save indent
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        return neocomplcache#smart_close_popup() . "\<CR>"
    endfunction
    "<TAB>: completion"
    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><C-Y> neocomplcache#close_popup()
    inoremap <expr><C-e> neocomplcache#cancel_popup()

    " C++ setting
    if !exists("g:neocomplcache_force_omni_patterns")
        let g:neocomplcache_force_omni_patterns = {}
    endif

    " omnifunc が呼び出される場合の世紀表現パターンを設定
    let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:]*\t]\%(\.\l->\)\l::'

    " nodejs
    if !exists('g:neocomplcache_omni_functions')
    	let g:neocomplcache_omni_functions = {}
    endif
    let g:neocomplcache_omni_functions.javascript = 'nodejscomplete#CompleteJS'
endif

let g:clang_complete_auto = 0

autocmd FileType python set omnifunc=pythoncomplete#Complete

filetype plugin indent on

function! s:Exec()
	exe "!" . &ft . " %"
:endfunction

command! Exec call <SID>Exec()

map <silent> <C-P> :call <SID>Exec()<CR>

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

autocmd FileType javascript setlocal omnifunc=nodejscomplete#CompleteJS

let g:node_usejscomplete = 1
" javascript library syntax
let g:used_javascript_libs = 'angularjs'

autocmd BufWritePre * :%s/\s\+$//e

" soralized color
syntax enable
set background=dark
let g:solarized_termtrans=1
colorscheme solarized

" browser reload
let g:returnApp = "iTerm"
nmap <Space>bc :ChromeReloadStart<CR>
nmap <Space>bC :ChromeReloadStop<CR>
nmap <Space>bf :FirefoxReloadStart<CR>
nmap <Space>bF :FirefoxReloadStop<CR>
nmap <Space>bs :SafariReloadStart<CR>
nmap <Space>bS :SafariReloadStop<CR>
nmap <Space>bo :OperaReloadStart<CR>
nmap <Space>bO :OperaReloadStop<CR>
nmap <Space>ba :AllBrowserReloadStart<CR>
nmap <Space>bA :AllBrowserReloadStop<CR>

" power line settings
let g:Powerline_symbols='fancy'
set t_Co=256

"let g:Powerline_theme='short'
let g:Powerline_colorscheme='solarized256_dark'

