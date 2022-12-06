#!/usr/bin/env fish

# Install bash configuration
#./bash/install.sh 

# Copy vimrc
cp .vimrc $HOME/.vimrc

# Copy git configuration
cp .gitconfig $HOME/.gitconfig

cp -r .ssh $HOME/.ssh

# Copy other configuration files into ~/.config
cp -r .config/* $HOME/.config/

# Source new configuration 
source $HOME/.config/fish/config.fish

# Install APT packages if on Debian/Ubuntu
if which apt
	./apt/install.sh
end

# Install Pacman packages if on Arch
if which pacman
	./archlinux/install.sh
end 

