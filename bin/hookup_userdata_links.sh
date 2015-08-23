#!/bin/bash
# Move original files to .orig_files folder
# create links to those files/folders in userdata

USER=mjl
USERDATADIR=/userdata/${USER}/
USERDOTFILESDIR=${USERDATADIR}dotfiles/

# link to the directories in userdata
declare -A USERDIRS=(\
		[bin]=${USERDATADIR}bin\
		[Documents]=${USERDATADIR}Documents\
		[Downloads]=${USERDATADIR}Downloads\
		[Music]=${USERDATADIR}Music\
		[Pictures]=${USERDATADIR}Pictures\
		[Projects]=${USERDATADIR}Projects\
		[Videos]=${USERDATADIR}Videos\
	)

# link to the configuration directories in userdata that are not in dotfiles (too large or too sensitive for github)
declare -A USERCONFIGFILES=(\
		[.config/Atlassian]=${USERDATADIR}.config/Atlassian\
		[.config/bcompare]=${USERDATADIR}.config/bcompare\
		[.config/chromium]=${USERDATADIR}.config/chromium\
		[.config/keepassx]=${USERDATADIR}.config/keepassx\
		[.config/libreoffice]=${USERDATADIR}.config/libreoffice\
		[.config/ReText\ project]=${USERDATADIR}.config/ReText\ project\
		[.dia]=${USERDATADIR}.dia\
		[.mozilla]=${USERDATADIR}.mozilla\
		[.purple]=${USERDATADIR}.purple\
		[.smartgit]=${USERDATADIR}.smartgit\
		[.ssh]=${USERDATADIR}.ssh\
	)

# link to the configuration files and directories in the dotfiles repository
declare -A USERDOTFILES=(\
		[.bash_aliases]=${USERDOTFILESDIR}bash_aliases\
		[.bashrc]=${USERDOTFILESDIR}bashrc
		[.ctags]=${USERDOTFILESDIR}ctags
		[.gitconfig]=${USERDOTFILESDIR}gitconfig
		[.gvimrc]=${USERDOTFILESDIR}gvimrc
		[.hgrc]=${USERDOTFILESDIR}hgrc
		[.inputrc]=${USERDOTFILESDIR}inputrc
		[.profile]=${USERDOTFILESDIR}profile
		[.vim]=${USERDOTFILESDIR}vim
		[.vimrc]=${USERDOTFILESDIR}vimrc
		[.dir_colors]=${USERDOTFILESDIR}dircolors.ansi-dark
		[.kde/share/apps/konsole/Solarized\ Dark.colorscheme]=${USERDOTFILESDIR}kde/share/apps/konsole/Solarized\ Dark.colorscheme\
		[.kde/share/apps/konsole/Solarized\ Light.colorscheme]=${USERDOTFILESDIR}kde/share/apps/konsole/Solarized\ Light.colorscheme\
		[.kde/share/apps/konsole/Solarized\ MJL.colorscheme]=${USERDOTFILESDIR}kde/share/apps/konsole/Solarized\ MJL.colorscheme\
	)

pushd ~

mkdir -p userdata_backup/config
echo Moving existing files to backup location...
mv --verbose --backup=numbered --t userdata_backup/ ${!USERDIRS[@]}
mv --verbose --backup=numbered --t userdata_backup/config ${!USERCONFIGFILES[@]}
mv --verbose --backup=numbered --t userdata_backup/ ${!USERDOTFILES[@]}

for f in "${!USERDIRS[@]}"
do
    echo linking $f to ${USERDIRS[$f]}...
    ln -s "${USERDIRS[$f]}" "$f"
done

for f in "${!USERCONFIGFILES[@]}"
do
    echo linking $f to ${USERCONFIGFILES[$f]}...
    ln -s "${USERCONFIGFILES[$f]}" "$f"
done

for f in "${!USERDOTFILES[@]}"
do
    echo linking $f to ${USERDOTFILES[$f]}...
    ln -s "${USERDOTFILES[$f]}" "$f"
done

popd
