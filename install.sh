#!/usr/bin/env fish

# Install bash configuration
#./bash/install.sh 

# Copy git configuration
cp git/gitconfig $HOME/.gitconfig

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
	./arch/install.sh
end 

