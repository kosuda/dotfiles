#! /bin/bash

for file in `find $HOME/dotfiles -name '.*' -maxdepth 0 |grep -v 'dotfiles/.git$' |perl -nle 'm!dotfiles/(.+)$! and print $1'`; do
    ln -sf $HOME/dotfiles/$file $HOME/$file
done

