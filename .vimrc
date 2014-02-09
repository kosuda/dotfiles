set tabstop=4
set autoindent
set expandtab
set shiftwidth=4
set laststatus=2
set ignorecase
set smartcase
set mouse=a
set nu
set visualbell
set hlsearch

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
NeoBundle 'Shougo/neocomplcache'
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

nmap <Leader>n : NERDTreeToggle<CR>

highlight SpellBad cterm=NONE ctermfg=white ctermbg=black

let g:neocomplcache_enable_at_startup = 1
autocmd FileType python set omnifunc=pythoncomplete#Complete

filetype plugin indent on

function! s:Exec()
	exe "!" . &ft . " %"
:endfunction

command! Exec call <SID>Exec()

map <silent> <C-P> :call <SID>Exec()<CR>

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

autocmd FileType javascript setlocal omnifunc=nodejscomplete#CompleteJS

if !exists('g:neocomplcache_omni_functions')
	let g:neocomplcache_omni_functions = {}
endif
let g:neocomplcache_omni_functions.javascript = 'nodejscomplete#CompleteJS'

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

