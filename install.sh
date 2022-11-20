#!/usr/bin/env bash

function doIt() {
	# Put Bash config files into place
	cp "bash/bashrc" $HOME/.bashrc 

	# Add PWD to $HOME/.bash_profile as DOTFILES_DIR so we can use it to reference other files from this directory
	echo -e "$(head -n 1 bash/bash_profile)\nDOTFILES_DIR=$PWD\n\n$(tail -n +2 bash/bash_profile)" > $HOME/.bash_profile

	# Source our new bash file
	source $HOME/.bash_profile;

	# Copy git configuration
	cp git/gitconfig $HOME/.gitconfig

	# Copy other configuration files into ~/.config
	cp -r .config/* $HOME/.config/
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;

unset doIt;

