# ~/.bash_aliases: executed by .bashrc

# some more ls aliases
alias ll='ls -lF --group-directories-first'
alias lla='ll -a'
alias la='ls -A'
alias l='ls -CF'

# setting the NO_AT_BRIDGE is needed (for me w/ 20.04) to prevent
#   dbind-WARNING **: Couldn't register with accessibility bus...
# when starting gvim from the console. see:
# - https://unix.stackexchange.com/questions/532585/getting-dbind-warnings-about-registering-with-the-accessibility-bus
# - https://wiki.gnome.org/Accessibility/Documentation/GNOME2/Mechanics
alias e='NO_AT_BRIDGE=1 gvim --remote-silent'
alias md='mkdir'

# run npm scripts w/o the long npm ERR: msgs
alias npmrs='npm run --silent $*'

# From the LinuxMint 16 .bashrc
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# From Scott McCammon's comment on https://www.eriwen.com/bash/pushd-and-popd
function mypushd {
	pushd "${@}" >/dev/null;
	dirs -v;
}

function mypopd {
	popd "${@}" >/dev/null;
	dirs -v;
}

alias d='dirs -v'
alias p='mypushd'
alias o='mypopd'
