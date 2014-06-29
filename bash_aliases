# ~/.bashi_aliases: executed by .bashrc

# some more ls aliases
alias ll='ls -l'
alias lla='ll -a'
alias la='ls -A'
alias l='ls -CF'

alias e='gvim --remote-silent'
alias md='mkdir'

# From the LinuxMint 16 .bashrc
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
