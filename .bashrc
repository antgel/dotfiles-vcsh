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

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
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
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.aliases ]; then
    . ~/.aliases
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

# Set readline to vi mode
set -o vi

### Starship prompt
eval "$(starship init bash)"

### General $PATH changes

# Android
export ANDROID_HOME=$HOME/Android/Sdk
export PATH="$ANDROID_HOME/tools:$PATH"

export PATH="/usr/lib/ccache:$PATH" # ccache
export PATH="$HOME/.local/bin:$PATH" # pip install --local uses this

# Debian bits
export DEB_BUILD_OPTIONS=parallel=8

# Elastic Beanstalk CLI
export PATH="/home/antony/.ebcli-virtual-env/executables:$PATH"

# fly.io
export FLYCTL_INSTALL="$HOME/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# locate that works in encrypted $HOME
if [ -f "$HOME/mlocate.db" ]; then
    export LOCATE_PATH="$HOME/mlocate.db"
fi

# Meteor
export PATH="$HOME/.meteor:$PATH"

# Go
export GOPATH="$HOME/gopath"
export PATH="$GOPATH:$GOPATH/bin:$PATH"

# npm local modules, from
# https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md
export NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$NPM_PACKAGES/bin:$PATH"
# Unset manpath so we can inherit from /etc/manpath via the `manpath`
# command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
# jasmine-spec-reporter needs this to play ball
export NODE_PATH="${HOME}/.npm-packages/lib/node_modules"

# ruby stuff
# rjb gem needs this
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")

# SDKMAN! for Groovy
export SDKMAN_DIR="/home/antony/.sdkman"
[[ -s "/home/antony/.sdkman/bin/sdkman-init.sh" ]] && source "/home/antony/.sdkman/bin/sdkman-init.sh"

# Terragrunt
# Don't take up so much disk space by duplicating unnecessarily
export TERRAGRUNT_DOWNLOAD="$HOME/.cache/terragrunt"
export TF_PLUGIN_CACHE_DIR="$TERRAGRUNT_DOWNLOAD/.plugins"

# thefuck
if command -v thefuck >/dev/null 2>&1; then
    eval "$(thefuck --alias)"
fi

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
# Why do the docs define $PROJECT_HOME? Never used in anything I've done
export PROJECT_HOME=$HOME/Devel
if command -v virtualenvwrapper.sh >/dev/null 2>&1; then
    . virtualenvwrapper.sh
fi

# There are some things one doesn't want in a public git repository. :)
if [ -f ~/.bash_private ]; then
    . ~/.bash_private
fi

# rbenv installed at system level by apt install rbenv
eval "$(rbenv init -)"
