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
" " Go編集時はタブにする
autocmd FileType go setlocal noexpandtab list tabstop=2 shiftwidth=2
autocmd FileType go set nolist

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

set nocompatible
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
  \ },
  \ }

" ディレクトリ表示
NeoBundle 'The-NERD-tree'

nmap <Leader>n : NERDTreeToggle<CR>

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
NeoBundleLazy 'Blackrush/vim-gocode', {
    \'autoload' : {
    \   'filetypes' : ['go']
    \}}

let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

set rtp+=$GOROOT/misc/vim
exe "set rtp+=" . globpath($GOPATH, "src/github.com/golang/lint/misc/vim")

" 保存時の自動フォーマット
auto BufWritePre *.go Fmt

let g:syntastic_go_checkers = ['go', 'golint', 'govet']

" <C-p>で実行
function! s:Exec()
	exe "!" . &ft . " %"
:endfunction

command! Exec call <SID>Exec()
map <silent> <C-P> :call <SID>Exec()<CR>

" 前回終了したカーソル行から開始
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//e

filetype plugin indent on
syntax on
NeoBundleCheck

