#!/bin/sh
#brew update
brew upgrade

# install of homebrew-cask
brew tap phinze/homebrew-cask || true
brew tap homebrew/versions || true
brew tap homebrew/binary || true

brew install brew-cask

# install packages
brew install android-ndk
brew install android-sdk
brew install ansible
brew install ant
brew install bzr
brew install casperjs
brew install direnv
brew install elasticsearch
brew install fontforge
brew install fuse4x
brew install fzf
brew install git
brew install go
brew install jmeter
brew install lua
brew install mercurial
brew install mobile-shell
brew install mongodb
brew install mysql
brew install ntfs-3g
brew install nvm
brew install phantomjs
brew install postgresql
brew install redis
brew install sqlite3
brew install subversion
brew install tmux
brew install tree
brew install vim --with-lua
brew install zsh

# install .dmg
brew cask install appcleaner
brew cask install caffeine
brew cask install clipmenu
brew cask install cyberduck
brew cask install dropbox
brew cask install firefox
brew cask install google-chrome
brew cask install google-drive
brew cask install google-japanese-ime
brew cask install handbrake
brew cask install hyperswitch
brew cask install imagealpha
brew cask install imageoptim
brew cask install iterm2
brew cask install mou
brew cask install osxfuse
brew cask install skype
brew cask install sourcetree
brew cask install texturepacker
brew cask install utorrent
brew cask install vagrant
brew cask install virtualbox
brew cask install vlc
brew cask install xtrafinder

#brew cask alfred link

# remove outdated versions
brew cleanup

