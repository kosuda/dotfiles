source ~/dotfiles/.vim/vimrc.d/vimrc.bundle

source ~/dotfiles/.vim/vimrc.d/vimrc.bundle.config

" 256色使用
set t_Co=256
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
" ヤンクでクリップボードにコピー
set clipboard=unnamed,autoselect

" カーソル設定
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" 矢印キーを無効化
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

" html, js indent
autocmd! FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd! FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
" *.goはGoで開く
autocmd BufNewFile,BufRead *.go setlocal filetype=go
" Go編集時はタブにする
autocmd FileType go setlocal noexpandtab list tabstop=2 shiftwidth=2
autocmd FileType go set nolist
autocmd FileType go,neosnippet setl noet noci nopi
" 前回終了したカーソル行から開始
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//e

