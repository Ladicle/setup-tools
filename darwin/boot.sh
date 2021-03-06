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
brew install \
     aspell \
     imagemagick \
     cheat \
     cmigemo \
     ctags \
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
     source-highlight \
     xmlstarlet \
     colordiff \
     emacs \
     global --with-sqlite3 \
     knqyf263/pet/pet \
     npm \
     direnv

brew tap sachaos/todoist && brew install todoist
brew tap Ladicle/toggl && brew install toggl
brew cask install marp

echo; echo -n "Setup commands for ZLab? (y/n): "; read ans
if [ $ans == 'y' ]; then
    brew install \
         kubernetes-cli \
         vault \
         stern \
         coreutils \
         kubectx
fi

# setup dotfiles
export GOPATH=$HOME/Developments
[ ! -d $GOPATH ] && mkdir $GOPATH
[ ! -d $GOPATH/src/github.com/Ladicle ] &&\
    mkdir -p $GOPATH/src/github.com/Ladicle

if [ ! -d $GOPATH/src/github.com/Ladicle/dotfiles ]; then
    cd $GOPATH/src/github.com/Ladicle
    git clone git@github.com:Ladicle/dotfiles.git
else
    cd $GOPATH/src/github.com/Ladicle/dotfiles
    git fetch && git rebase origin master
fi

cd $GOPATH/src/github.com/Ladicle/dotfiles
bash install.sh osx

# install go commands
go get -u github.com/motemen/ghq
go get -u golang.org/x/tools/...
go get -u github.com/rogpeppe/godef
go get -u github.com/nsf/gocode
go get -u github.com/golang/lint/golint
go get -u github.com/kisielk/errcheck
go get -u github.com/juntaki/gogtags
go get -u github.com/derekparker/delve/cmd/dlv
go get -u github.com/murooka/go-diff-image/...

# setup fisher
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fish -c "fisher install z"
fish -c "fisher install otms61/fish-pet"

# my scripts
ghq get -p Ladicle/misc-scripts
ghq get -p Ladicle/setup-tools
ghq get -p Ladicle/go-snippets

# setup emacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
ln -Fis $GOPATH/src/github.com/Ladicle/go-snippets $HOME/.emacs.d/private/snippets/go-mode

# setup commands
cd $HOME
hub issue || :
toggl || :
todoist || :

echo "generate access token (only need gist scope)"
echo "title:  pet for $USER@(hostname)"
open https://github.com/settings/tokens
pet configure || :

echo "paste Gist ID to pet configure"
pet sync -u || :
pet configure || :

# SKK
gem install google-ime-skk
