#! /bin/bash
#
# This script will backup existing files in ~ and then replace them with symlinks
# to the files/directories in /userdata/${USER} .
#
# It is meant to be used when doing a clean install of a new distribution and the
# home directory has no customized files.
# A userdata filesystem (partition) that contains files that were in use in
# another distribution is intended to have been mounted via fstab at /userdata
#
# usage:
#     create-userdata-links.sh

USER=mjl

# simplistic backup of these files we want to replace w/ links
mkdir ~/userdata_backup
mv --verbose --backup=numbered --t ~/userdata_backup ~/bin ~/Documents ~/Downloads ~/Music ~/Pictures ~/Projects ~/Videos
mkdir ~/userdata_backup/config
mv --verbose --backup=numbered --t ~/userdata_backup/config ~/.config/Atlassian ~/.config/bcompare ~/.config/chromium ~/.config/keepassx ~/.config/libreoffice ~/.config/quassel-irc.org "~/.config/ReText project"
mv --verbose --backup=numbered --t ~/userdata_backup ~/.dia ~/.mozilla ~/.purple ~/.smartgit ~/.ssh
mv --verbose --backup=numbered --t ~/userdata_backup ~/.bash_aliases ~/.bashrc ~/.ctags ~/.gitconfig ~/.gvimrc ~/.hgrc ~/.inputrc ~/.vim ~/.vimrc


# link to the directories in userdata
ln -s /userdata/${USER}/bin ~/bin
ln -s /userdata/${USER}/Documents ~/Documents
ln -s /userdata/${USER}/Downloads ~/Downloads
ln -s /userdata/${USER}/Music ~/Music
ln -s /userdata/${USER}/Pictures ~/Pictures
ln -s /userdata/${USER}/Projects ~/Projects
ln -s /userdata/${USER}/Videos ~/Videos

# link to the configuration directories in userdata that are not in dotfiles (too large or too sensitive for github)
ln -s /userdata/${USER}/.config/Atlassian ~/.config/Atlassian
ln -s /userdata/${USER}/.config/bcompare ~/.config/bcompare
ln -s /userdata/${USER}/.config/chromium ~/.config/chromium
ln -s /userdata/${USER}/.config/keepassx ~/.config/keepassx
ln -s /userdata/${USER}/.config/libreoffice ~/.config/libreoffice
ln -s /userdata/${USER}/.config/ReText\ project ~/.config/ReText\ project
ln -s /userdata/${USER}/.dia ~/.dia
ln -s /userdata/${USER}/.mozilla ~/.mozilla
ln -s /userdata/${USER}/.purple ~/.purple
ln -s /userdata/${USER}/.smartgit ~/.smartgit
ln -s /userdata/${USER}/.ssh ~/.ssh

# link to the configuration files and directories in the dotfiles repository
ln -s /userdata/${USER}/dotfiles/bash_aliases ~/.bash_aliases
ln -s /userdata/${USER}/dotfiles/bashrc ~/.bashrc
ln -s /userdata/${USER}/dotfiles/ctags ~/.ctags
ln -s /userdata/${USER}/dotfiles/gitconfig ~/.gitconfig
ln -s /userdata/${USER}/dotfiles/gvimrc ~/.gvimrc
ln -s /userdata/${USER}/dotfiles/hgrc ~/.hgrc
ln -s /userdata/${USER}/dotfiles/inputrc ~/.inputrc
ln -s /userdata/${USER}/dotfiles/vim ~/.vim
ln -s /userdata/${USER}/dotfiles/vimrc ~/.vimrc
