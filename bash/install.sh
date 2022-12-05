#/usr/bin/env bash

set -e 

# Put Bash config files into place
cp "bash/bashrc" $HOME/.bashrc 

# Add PWD to $HOME/.bash_profile as DOTFILES_DIR so we can use it to reference other files from this directory
echo -e "$(head -n 1 bash/bash_profile)\nDOTFILES_DIR=$PWD\n\n$(tail -n +2 bash/bash_profile)" > $HOME/.bash_profile

# Source our new bash file
source $HOME/.bash_profile;
