if status is-interactive

	set -gx EDITOR vim
	set -gx _JAVA_AWT_WM_NONREPARENTING 1
	set -gx MOZ_ENABLE_WAYLAND 1
	set -U fish_user_paths /home/danny/.cargo/bin

end
