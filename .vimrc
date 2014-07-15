if has('vim_starting')
    set runtimepath+=~/.vim/neobundle.vim/
endif
call neobundle#rc()

" neobundle自身をneobundleで管理する
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin' : 'make -f make_cygwin.mak',
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix' : 'make -f make_unix.mak',
  \ }}

" ディレクトリ表示
NeoBundle 'The-NERD-tree'

nmap <Leader>n : NERDTreeToggle<CR>
" バッファが無くなった時にnerd treeも閉じる
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" snippets
NeoBundleLazy 'Shougo/neosnippet', {
    \ 'autoload': {
    \   'insert': 1,
    \ }}
imap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
let g:neosnippet#snippets_directory = '~/.vim/snippets'

" syntastic
NeoBundle 'scrooloose/syntastic'

" soralized color
NeoBundle 'altercation/vim-colors-solarized'

syntax enable
set background=dark
let g:solarized_termtrans=1
colorscheme solarized
hi Comment ctermfg=darkgray

" python (TODO)
NeoBundleLazy 'lambdalisue/vim-python-virtualenv', {
    \ 'autoload': {
    \   'filetype': ['python']
    \ }}
NeoBundleLazy 'mitechie/pyflakes-pathogen', {
    \ 'autoload': {
    \   'filetype': ['python']
    \ }}
NeoBundleLazy 'reinh/vim-makegreen', {
    \ 'autoload': {
    \   'filetype': ['python']
    \ }}
NeoBundleLazy 'lambdalisue/nose.vim', {
    \ 'autoload': {
    \   'filetype': ['python']
    \ }}
"NeoBundle 'sontek/rope-vim'
NeoBundleLazy 'git://github.com/vim-scripts/pythoncomplete.git', {
    \ 'autoload': {
    \   'filetype': ['python']
    \ }}

autocmd FileType python set omnifunc=pythoncomplete#Complete

" javascript, node.js
NeoBundleLazy 'JavaScript-syntax', {
    \ 'autoload': {
    \   'filetype': ['js']
    \ }}
NeoBundleLazy 'pangloss/vim-javascript', {
    \ 'autoload': {
    \   'filetype': ['js']
    \ }}
NeoBundleLazy 'myhere/vim-nodejs-complete', {
    \ 'autoload': {
    \   'filetype': ['js']
    \ }}

" javascript libraries syntax
NeoBundleLazy 'othree/javascript-libraries-syntax.vim', {
    \ 'autoload' : {
    \   'filetype' : ['js', 'html', 'htm']
    \ }}

" javascript library syntax
let g:used_javascript_libs = 'angularjs'

" web開発系
NeoBundleLazy 'mattn/emmet-vim', {
    \ 'autoload' : {
    \   'filetype' : ['html', 'htm']
    \ }}
"" これはweb以外でも使うのでlazy loadしない
NeoBundle 'tpope/vim-surround'

NeoBundleLazy 'othree/html5.vim', {
    \ 'autoload' : {
    \   'filetype' : ['html', 'htm']
    \ }}
NeoBundleLazy 'hail2u/vim-css3-syntax', {
    \ 'autoload' : {
    \   'filetype' : ['css']
    \ }}

" power line
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'stephenmckinney/vim-solarized-powerline'

let g:Powerline_symbols='fancy'
set t_Co=256

let g:Powerline_colorscheme='solarized256_dark'

highlight SpellBad cterm=NONE ctermfg=white ctermbg=black

" neocomplcache, neocomplete
function! s:meet_neocomplete_requirements()
    return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction

function! s:my_cr_function()
    return neocomplcache#smart_close_popup() . "\<CR>"
endfunction

if s:meet_neocomplete_requirements()
    NeoBundleLazy 'Shougo/neocomplete.vim', {
        \ 'autoload': {
        \   'insert': 1
        \ }}
    NeoBundleFetch 'Shougo/neocomplcache.vim'
else
    NeoBundleFetch 'Shougo/neocomplete.vim'
    NeoBundleLazy 'Shougo/neocomplcache.vim', {
        \ 'autoload': {
        \   'insert': 1
        \ }}
endif

autocmd FileType javascript setlocal omnifunc=nodejscomplete#CompleteJS

if s:meet_neocomplete_requirements()
    "新しい設定
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#max_list = 20
    let g:neocomplete#min_keyword_length = 3
    let g:neocomplete#force_overwrite_completefunc = 1

    inoremap <expr><C-l> neocomplete#complete_common_string()
    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"

    if !exists("g:neocomplete#sources#omni#functions")
        let g:neocomplete#sources#omni#functions = {}
    endif

    let g:neocomplete#sources#omni#functions.javascript = 'nodejscomplete#CompleteJS'

    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif

    let g:neocomplete#sources#omni#input_patterns.go = '[^.[:digit:] *\t]\.\w*'
else
    " 今までの設定
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_min_syntax_length = 3
    let g:neocomplcache_force_overwrite_completefunc = 1

    inoremap <expr><C-g> neocomplcache#undo_completion()
    inoremap <expr><C-l> neocomplcache#complete_common_string()
    " Recommended key-mappings
    " <CR>: close popup and save indent
    inoremap <silent><CR><C-r>=<SID>my_cr_function()<CR>
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
    let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

    " nodejs
    if !exists('g:neocomplcache_omni_functions')
    	let g:neocomplcache_omni_functions = {}
    endif
    let g:neocomplcache_omni_functions.javascript = 'nodejscomplete#CompleteJS'
endif

let g:node_usejscomplete = 1

" go lang
NeoBundleLazy 'fatih/vim-go', {
    \'autoload' : {
    \   'filetypes' : ['go']
    \}}

let g:syntastic_go_checkers = ['go', 'golint', 'govet']
let s:hooks = neobundle#get_hooks('vim-go')
function! s:hooks.on_source(bundle)
    let g:go_bin_path = expand('$HOME/.go/bin')
    let g:go_disable_autoinstall = 1
    let g:go_fmt_autosave = 1
    let g:go_fmt_command = 'gofmt'
    let g:go_fmt_fail_silently = 1 " use syntasitic to check errors
    let g:go_play_open_browser = 0
    let g:go_snippet_engine = 'neosnippet'
    let g:neosnippet#snippets_directory .= ',~/.vim/bundle/vim-go/gosnippets/snippets'

    augroup MyGoAutocmd
        autocmd!
        autocmd FileType go nmap <LocalLeader>i <Plug>(go-info)
        autocmd FileType go nmap <LocalLeader>gd <Plug>(go-doc)
        autocmd FileType go nmap <LocalLeader>gv <Plug>(go-doc-vertical)
        autocmd FileType go nmap <LocalLeader>gb <Plug>(go-build)
        autocmd FileType go nmap <LocalLeader>gt <Plug>(go-test)
        autocmd FileType go nmap gd <Plug>(go-def)
        autocmd FileType go nmap <LocalLeader>ds <Plug>(go-def-split)
        autocmd FileType go nmap <LocalLeader>dv <Plug>(go-def-vertical)
        autocmd FileType go nmap <LocalLeader>gl :GoLint<CR>
    augroup END
endfunction
unlet s:hooks
autocmd FileType go,neosnippet setl noet noci nopi

NeoBundleLazy 'thinca/vim-quickrun', {
    \ 'commands' : 'QuickRun',
    \ 'mappings' : [
    \   ['nxo', '<Plug>(quickrun)']],
    \ }
nmap <Leader>r <Plug>(quickrun)
let s:hooks = neobundle#get_hooks('vim-quickrun')
function! s:hooks.on_source(bundle)
    let g:quickrun_config = {
        \ '_' : {
        \   'runner' : 'vimproc',
        \   'runner/vimproc/updatetime': 10,
        \   'hook/time/enable' : 1,
        \   'outputter/buffer/close_on_empty': 1,
        \   'outputter/buffer/split' : ':botright 5sp',
        \ },
        \ 'go': {
        \   'command': 'go',
        \   'exec': ['%c run %s'],
        \ }}


endfunction
unlet s:hooks

filetype plugin indent on
syntax on
NeoBundleCheck

" 改行時に自動でインデントを挿入
set autoindent
" タブの設定
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
" ステータスラインの表示
set laststatus=2
" 検索機能
set ignorecase
set smartcase
" 行番号表示
set nu
" ビープ音を消す
set visualbell
" 検索結果をハイライト
set hlsearch
" ファイルの候補を表示
set wildmenu
" insertモードでバックスペース有効化
set backspace=indent,eol,start

" html, js indent
autocmd! FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd! FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
" *.goはGoで開く
autocmd BufNewFile,BufRead *.go setlocal filetype=go
" Go編集時はタブにする
autocmd FileType go setlocal noexpandtab list tabstop=2 shiftwidth=2
autocmd FileType go set nolist
" 前回終了したカーソル行から開始
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//e

" カーソル設定
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

set nocompatible

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

inoremap <silent> <C-h> <C-g>u<C-h>
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

map <Left> <Esc>:bp<CR>
map <Right> <Esc>:bn<CR>

