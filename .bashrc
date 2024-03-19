[ "$(tty)" = "/dev/tty1" ] && exec sway

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Set prompt to a simply "$PWD >"
PS1='\[\033[01;34m\]\w\[\033[00m\] > '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|foot)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias grep='grep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Load aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH="$PATH:/home/danny/Code/dotfiles/bin"
export PATH="$PATH:/home/danny/.local/bin"
export PATH="$PATH:/home/danny/go/bin"
export CXX="$HOME/gcc-13.2.0/bin/g++"
export CC="$HOME/gcc-13.2.0/bin/gcc"
source "$HOME/.cargo/env"
source "$HOME/.env"

# Advent of Code shortcuts
aocmake () {
    make $1 && cat "${2:-$1.txt}" | ./$1
}
export aocmake

alias aocc="$CC-17 -g -Wall -Wextra -Wpedantic -Wshadow -Wfloat-equal -Wswitch-enum -Wconversion -Wunreachable-code -fsanitize=undefined -fsanitize=address -Wformat=2 -O2 main.c -lcrypto && ./a.out"
alias aoccf="$CC -O2 -march=native -mtune=native -flto main.c -lcrypto && ./a.out"

# Nvim in PATH
export PATH="$PATH:/opt/nvim-linux64/bin"
alias vim="nvim"

# Set nvim as editor for lots of things
export VISUAL=nvim
export EDITOR="$VISUAL"

osc7_cwd() {
    local strlen=${#PWD}
    local encoded=""
    local pos c o
    for (( pos=0; pos<strlen; pos++ )); do
        c=${PWD:$pos:1}
        case "$c" in
            [-/:_.!\'\(\)~[:alnum:]] ) o="${c}" ;;
            * ) printf -v o '%%%02X' "'${c}" ;;
        esac
        encoded+="${o}"
    done
    printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
}
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }osc7_cwd

alias calc="bc -l"

# Always enable warnings from -Wall and -Wextra
export CFLAGS="-Wall -Wextra -Wvla -Wformat -Wformat=2"
export CXXFLAGS="-Wall -Wextra -Weffc++"

# Let CMake always dump compile_commands.json (for Clangd)
export CMAKE_EXPORT_COMPILE_COMMANDS="ON"

# capture the output of a command so it can be retrieved with ret
cap () { tee /tmp/capture.out; }

# return the output of the most recent command that was captured by cap
ret () { cat /tmp/capture.out; }
