# 環境変数
export LANG=ja_JP.UTF-8
# homebrew > macports > default
export PATH=/usr/local/bin:/opt/local/bin:/opt/local/sbin:$PATH
export LSCOLORS=gxfxcxdxbxegedabagacad
export SVN_EDITOR=vim
# 色付け
autoload -Uz colors
colors
# historyのせってい
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
# prompt
# 1行表示
# prompt="%~ %# "
# 2行表示
PROMPT="%{${fg[red]}%}[%n@%m]%{${reset_color}%} %~
> "
# 単語の区切り文字をしてい
autoload -Uz select-word-style
select-word-style default
# ここでしていた文字は単語区切りとみなされる
# / も区切りと扱うので、^Wでディレクトリ1つ分を削除できる
zstyle ':zle:*' world-chars " /=;@:{},|"
zstyle ':zle:*' world-style unspecified

# 補完
# 補完機能強化
fpath=(/usr/local/zsh-completions/src $fpath)
# 補完機能を有効化
autoload -Uz compinit
compinit
# 補完で小文字でも大文字でもマッチ
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# ../の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..
# sudoの後ろでコマンド名を補完
zstyle ':completion:*:sudo:*' command-path /usr/local/bin /opt/local/bin /usr/bin /usr/sbin ~/bin
# ps今度のプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

#vcs_info
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{green}%1v%f|)"

# 日本語ファイル名表示
setopt print_eight_bit
# beepを無効化
setopt no_beep
# フローコントロールを無効化
setopt no_flow_control
# '#'以降をコメントとして扱う
setopt interactive_comments
# ディレクトリ名だけcd
setopt auto_cd
# cdしたら自動でpushd
setopt auto_pushd
# 重複ディレクトリを追加しない
setopt pushd_ignore_dups
# =の後はパス名として補完する
setopt magic_equal_subst
# 同時に起動したzshの間でヒストリを共有
setopt share_history
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
# history fileに保存するときにすでに重複したコマンドがあったら古い方を削除
setopt hist_save_nodups
# spaceから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
# 補完候補が複数あるときに自動的に一覧表示する
setopt auto_menu
# 高機能なワイルドカード展開を使用
setopt extended_glob

# ^Rで履歴検索するときに*でワイルドカードを使用できるようにする
bindkey '^R' history-incremental-pattern-search-backward

alias la='ls -a'
alias ll='ls -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
# sudoの後のcommandでaliasを有効化
alias sudo='sudo '

alias -g L='| less'
alias -g G='| grep'

# mosh & ssh
function remote() {
    if [ $# -ne 2 ]; then
        cat <<__EOF__
usage:
    remote <host> <option>
(host)
    <host>.db.ics.keio.ac.jp
(option)
    -s : use ssh
    -m : use mosh
__EOF__
    return 1
    fi
    if [ $2 == "-s" ]; then
        ssh $1.db.ics.keio.ac.jp
    elif [ $2 == "-m" ]; then
        mosh $1.db.ics.keio.ac.jp
    else
        echo '-s or -m'
    fi
}

# Cで標準出力をclip boardにcopy
if which pbcopy >/dev/null 2>&1 ; then
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    alias -g C=' xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    alias -g C='| putclip'
fi

case ${OSTYPE} in
    darwin*)
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        ;;
esac

# mongo
alias mongostart='sudo mongod -f /usr/local/etc/mongod.conf &'
function mongostop() {
    local mongopid=`less /usr/local/var/mongodb/mongod.lock`
    if [[ $mongopid =~ [[:digit:]] ]]; then
        sudo kill -15 $mongopid
        echo mongod process $mongopid terminated
    else
        echo mongod process $mongopid not exist
    fi
}

# node
source ~/.nvm/nvm.sh
nvm use 0.10
export NODE_PATH=${NVM_PATH}_modules

# python
# source ~/.pythonbrew/etc/bashrc
# alias mkvenv='pythonbrew venv create'
# alias workon='pythonbrew venv use'
# alias rmvenv='pythonbrew venv delte'
# pythonbrew switch 3.3.1

# self create bin
PATH=$PATH:~/bin
export PATH

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT=/Users/kosuda/Documents/cocos2d-x-3.0rc2/tools/cocos2d-console/bin
export PATH=$COCOS_CONSOLE_ROOT:$PATH

