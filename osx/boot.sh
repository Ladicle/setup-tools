#!/bin/bash

cat <<EOF

███████╗███████╗████████╗██╗   ██╗██████╗      ██████╗ ███████╗██╗  ██╗       ██╗
██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗    ██╔═══██╗██╔════╝╚██╗██╔╝    ██╗╚██╗
███████╗█████╗     ██║   ██║   ██║██████╔╝    ██║   ██║███████╗ ╚███╔╝     ╚═╝ ██║
╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝     ██║   ██║╚════██║ ██╔██╗     ██╗ ██║
███████║███████╗   ██║   ╚██████╔╝██║         ╚██████╔╝███████║██╔╝ ██╗    ╚═╝██╔╝
╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝          ╚═════╝ ╚══════╝╚═╝  ╚═╝       ╚═╝

EOF

# check git command
git version

# show hidden files in finder
defaults write com.apple.finder AppleShowAllFiles -boolean true
killall Finder

# install commands using brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew cask install java
brew tap sachaos/todoist
brew install \
     aspell \
     bazel \
     imagemagick \
     cheat \
     cmigemo \
     ctags \
     emacs \
     fish \
     fzf \
     gdb \
     ag \
     tig \
     tree \
     tmux \
     go \
     hub \
     jq \
     todoist \
     dep \
     source-highlight

# setup dotfiles
export GOPATH=$HOME/Developments
[ ! -d $GOPATH ] && mkdir $GOPATH
[ ! -d $GOPATH/src/github.com/Ladicle ] &&\
    mkdir -p $GOPATH/src/github.com/Ladicle

if [ ! -d $GOPATH/src/github.com/Ladicle/dotfiles ]; then
    cd $GOPATH/src/github.com/Ladicle
    git clone git@github.com:Ladicle/dotfiles.git
fi

cd $GOPATH/src/github.com/Ladicle/dotfiles
bash install.sh osx

# setup hub command
cd $HOME
hub issue || :

# install go commands
go get -u github.com/motemen/ghq
go get -u github.com/Ladicle/toggl
go get -u golang.org/x/tools/...

# setup fisher
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fish -c "fisher install z"

# my scripts
ghq get -p Ladicle/misc-scripts
ghq get -p Ladicle/setup-tools
ghq get -p Ladicle/go-snippets

# setup emacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
ln -Fis $GOPATH/src/github.com/Ladicle/go-snippets $HOME/.emacs.d/private/snippets
