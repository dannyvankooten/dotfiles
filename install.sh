#!/usr/bin/env bash

function doIt() {
	# Put Bash config files into place
	cp "bash/bashrc" ~/.bashrc 

	# Add PWD to ~/.bash_profile as DOTFILES_DIR so we can use it to reference other files from this directory
	echo -e "$(head -n 1 bash/bash_profile)\nDOTFILES_DIR=$PWD\n\n$(tail -n +2 bash/bash_profile)" > ~/.bash_profile

	# Source our new bash file
	source ~/.bash_profile;

	# Checkout submodule for Vundle
	if [[ ! -e vim/bundle/Vundle.vim/README.md ]]; then
		git submodule init
		git submodule update
	fi;

	# Copy vim directory (to manage vim plugins)
	cp -r "$PWD/vim" ~/.vim

	# Copy git configuration
	cp git/gitconfig ~/.gitconfig
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

