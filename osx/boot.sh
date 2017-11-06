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
     dep

# setup dotfiles
[ ! -d $HOME/Developments ] && mkdir $HOME/Developments
[ ! -d $HOME/Developments/src/github.com/Ladicle ] &&\
    mkdir -p $HOME/Developments/src/github.com/Ladicle

if [ ! -d $HOME/Developments/src/github.com/Ladicle/dotfiles ]; then
    cd $HOME/Developments/src/github.com/Ladicle
    git clone git@github.com:Ladicle/dotfiles.git
fi

cd $HOME/Developments/src/github.com/Ladicle/dotfiles
bash install.sh osx

# setup hub command
cd $HOME
hub issue || :

# install go commands
export GO_SRC=$HOME/Developments/src
go get -u github.com/Ladicle/toggl
go get -u golang.org/x/tools/...

# よく使うやつ
ghq get -p Ladicle/misc-scripts
ghq get -p Ladicle/setup-tools
