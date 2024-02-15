#!/usr/bin/env sh

# Copy vimrc
cp .vimrc $HOME/.vimrc

# Copy git configuration
cp .gitconfig $HOME/.gitconfig

# Copy other configuration files into ~/.config
cp -r .ssh $HOME/.ssh
cp -r .config/* $HOME/.config/
cp .editorconfig $HOME/.editorconfig

# Install vim-plug (https://github.com/junegunn/vim-plug)
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install packages
xargs sudo apt-get -y install < packages.txt
