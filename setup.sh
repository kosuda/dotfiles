#! /bin/bash

DOT_FILES=(.vimrc,.gitconfig,.tmux.conf,.xvimrc,.zshrc)

if [ ! -d $HOME/.vim/bundle ]; then
    mkdir -p ~/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

for file in ${DOT_FILES[@]}; do
    ln -sf $HOME/dotfiles/$file $HOME/$file
done

if [ ! -d $HOME/.config/peco ]; then
    mkdir -p $HOME/.config/peco
fi

ln -sf $HOME/dotfiles/config/peco/config.json $HOME/.config/peco/config.json

