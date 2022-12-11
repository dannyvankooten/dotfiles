if status is-interactive

	set -gx EDITOR vim
	set -gx _JAVA_AWT_WM_NONREPARENTING 1
	set -gx MOZ_ENABLE_WAYLAND 1
end

# find dotfiles directory
set DOTFILES_DIR (find $HOME -maxdepth 3 -type d -name "dotfiles" | sed 1q)

# add some bin directories to path
set -U fish_user_paths $HOME/.cargo/bin $fish_user_paths
set -U fish_user_paths $HOME/.local/bin $fish_user_paths
set -U fish_user_paths $DOTFILES_DIR/bin $fish_user_paths 
set -U fish_user_paths /usr/local/go/bin

# source ~/.env file if it exists
if test -f $HOME/.env
    source $HOME/.env
end
