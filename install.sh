#!/usr/bin/env sh

# Copy vimrc
cp .vimrc $HOME/.vimrc

# Copy git configuration
cp .gitconfig $HOME/.gitconfig

# Copy other configuration files into ~/.config
cp -r .ssh $HOME/.ssh
cp -r .config/* $HOME/.config/
cp .editorconfig $HOME/.editorconfig

# Install APT packages if on Debian/Ubuntu
if command -v apt 
then 
	./apt/install.sh
fi

# Install Pacman packages if on Arch
if command -v pacman 
then
	./archlinux/install.sh
fi

# Install fonts (nerd fonts + fontawesome)
cp -r .fonts $HOME/.fonts 
fc-cache 

