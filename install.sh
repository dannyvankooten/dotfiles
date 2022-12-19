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
if type -q apt
	./apt/install.sh
end

# Install Pacman packages if on Arch
if type -q pacman
	./archlinux/install.sh
end 

# Install custom fonts
if not test -d $HOME/.fonts 
    echo "Installing FontAwesome5 font"
    wget https://use.fontawesome.com/releases/v5.15.1/fontawesome-free-5.15.1-desktop.zip -O /tmp/fontawesome.zip 
    mkdir $HOME/.fonts
    unzip /tmp/fontawesome.zip -d /tmp/fontawesome 
    cp /tmp/fontawesome/fontawesome-free-5.15.1-desktop/otfs/*.otf $HOME/.fonts/
    fc-cache -f -v 
end 
