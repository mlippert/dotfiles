# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
#export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth
# don't put 1 char cmd: 2 char cmd: previous cmd: cmd w/ leading space: exit: ls or ll cmd in history
# I know some of these are redundant or duplicate histcontrol -mjl
export HISTIGNORE="?:??:&:[ ]*:exit:l[sl]"

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# The following color settings are for a solarized palette
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u@\h\[\033[00;32m\] \w \[\033[01;36m\]\$\[\033[00m\] '
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

# Environment variables.

# Sort in "codepoint" order. otherwise ls, sort, others will use the language and sort in "natural" order
# possibly ignoring non alphabetic characters and sorting upper and lowercase together...
export LC_COLLATE=C

# Setting the PYTHONPATH is required by the mercurial install.
# (see http://mercurial.selenic.com/wiki/UnixInstall)
# shouldn't be needed anymore, python packages should install
# into dist-packages, see https://bugs.launchpad.net/ubuntu/+source/python2.6/+bug/362570
# in order to get the python modules installed to home on the path
# add a path configuration file (see http://docs.python.org/install/index.html)
# seems the path configuration file should go in ~/.local/lib/python2.7/site-packages
# export PYTHONPATH=/usr/local/lib/python2.7/site-packages

# This variable is used by the ripgrep (rg) utility identifying a configuration
# file to use. This points at the file I created for node projects.
export RIPGREP_CONFIG_PATH=~/Projects/node.rgrc

# This variable is used by the BrixClient's makefile to determine whether to use the
# jsdoc java or node code to build its doc.
export BRIX_JSDOC_BUILD=node

# This variable is useful on a remote machine (ie ssh'd in) when using gpg to encrypt/decrypt
# and you get the error: "gpg: public key decryption failed: Inappropriate ioctl for device"
# https://stackoverflow.com/questions/51504367/gpg-agent-forwarding-inappropriate-ioctl-for-device
# export GPG_TTY=$(tty)

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    if [ -f ~/.dir_colors ]; then
        eval "`dircolors -b ~/.dir_colors`"
    else
        eval "`dircolors -b`"
    fi

    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Function to format your PATH variable for easy viewing
# from http://www.cyberciti.biz/faq/howto-print-path-variable/
function path()
{
    old=$IFS
    IFS=:
    printf "%s\n" $PATH
    IFS=$old
}
