if status is-interactive
    # Commands to run in interactive sessions can go here
	starship init fish | source

	# Run pacmansyu
	pacmansyu 

	# Fix for Jetbrains IDE's using JDK
	set -gx _JAVA_AWT_WM_NONREPARENTING 1
end

set -gx EDITOR vim
set -gx _JAVA_AWT_WM_NONREPARENTING 1