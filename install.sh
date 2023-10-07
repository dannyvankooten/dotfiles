#!/usr/bin/env sh

# Copy vimrc
cp .vimrc $HOME/.vimrc

# Copy git configuration
cp .gitconfig $HOME/.gitconfig

# Copy other configuration files into ~/.config
cp -r .ssh $HOME/.ssh
#cp -r .config/* $HOME/.config/
cp .editorconfig $HOME/.editorconfig
