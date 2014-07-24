#!/bin/bash
# Move original files to .orig_files folder
# create links to those files/folders in userdata

USERDATADIR=/userdata/mjl/

declare -a USERFILES=(\
		.bash_aliases\
		.bashrc\
		.config/bcompare\
		.config/chromium\
		.config/keepassx\
		.config/libreoffice\
		.config/quassel-irc.org\
		.config/ReText\\ project\
		.dia\
		.gitconfig\
		.gvimrc\
		.kde/share/apps/ktorrent\
		.kde/share/config/ktorrentrc\
		.vimrc\
		.inputrc\
		.mozilla\
		.purple\
		.smartgit\
		.ssh\
		.vim\
		bin\
		Documents\
		Downloads\
		Music\
		Pictures\
		Projects\
		Videos\
	)

mkdir .orig_files

for t in "${USERFILES[@]}"
do
    mv $t .orig_files/
    ln -s ${USERDATADIR}$t $t
done
