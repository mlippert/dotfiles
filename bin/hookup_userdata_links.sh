#!/bin/bash
# Move original files to .orig_files folder
# create links to those files/folders in userdata

# Argument = -u user -d dotfiles_path -l all|dotfiles|userdata

usage()
{
cat << EOF
usage: $0 options

This backs up and then links to files in dotfiles and files in userdata
e.g.
$0 -u mjl -d /home/mjl/dotfiles/ -l dotfiles

OPTIONS:
   -h   Show this message
   -l   Files to link, can be 'all', 'dotfiles' or 'userdata' defaults to all
   -u   user name (links are created in /home/{user}, and userdata path is /userdata/{user}
        default user is mjl
   -d   Dotfiles path. defaults to {userdata_path}/dotfiles/
EOF
}

USER=mjl
DOTFILESDIR=
LINKDOTFILES=true
LINKUSERDATAFILES=true


while getopts “hl:u:d:” OPTION
do
    case $OPTION in
        h)
            usage
            exit 1
            ;;
        u)
            USER=$OPTARG
            ;;
        d)
            DOTFILESDIR=$OPTARG
            ;;
        l)
            case $OPTARG in
                all)
                    LINKDOTFILES=true
                    LINKUSERDATAFILES=true
                    ;;
                dotfiles)
                    LINKDOTFILES=true
                    LINKUSERDATAFILES=false
                    ;;
                userdata)
                    LINKDOTFILES=false
                    LINKUSERDATAFILES=true
                    ;;
                *)
                    usage
                    exit 1
                    ;;
            esac
            ;;
        ?)
            usage
            exit
            ;;
    esac
done

USERDATADIR=/userdata/${USER}/

# if unspecified on the command line, set the Dotfiles dir to the default in the /userdata dir
if [ "$DOTFILESDIR" = "" ]; then
    DOTFILESDIR=${USERDATADIR}dotfiles/
fi


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
		[.aws]=${USERDATADIR}.aws\
		[.config/Atlassian]=${USERDATADIR}.config/Atlassian\
		[.config/bcompare]=${USERDATADIR}.config/bcompare\
		[.config/calibre]=${USERDATADIR}.config/calibre\
		[.config/chromium]=${USERDATADIR}.config/chromium\
		[.config/discord]=${USERDATADIR}.config/discord\
		[.config/keepassxc]=${USERDATADIR}.config/keepassxc\
		[.config/KeePassXCrc]=${USERDATADIR}.config/KeePassXCrc
		[.config/libreoffice]=${USERDATADIR}.config/libreoffice\
		[.config/ReText\ project]=${USERDATADIR}.config/ReText\ project\
		[.config/Slack]=${USERDATADIR}.config/Slack\
		[.config/Signal]=${USERDATADIR}.config/Signal\
		[.config/smartgit]=${USERDATADIR}.config/smartgit\
		[.config/teamviewer]=${USERDATADIR}.config/teamviewer\
		[.config/ukuu]=${USERDATADIR}.config/ukuu\
		[.dia]=${USERDATADIR}.dia\
		[.docker]=${USERDATADIR}.docker\
		[.gnupg]=${USERDATADIR}.gnupg\
		[.gramps]=${USERDATADIR}.gramps\
		[.local/share/icons]=${USERDATADIR}.local/share/icons\
		[.local/share/wallpapers]=${USERDATADIR}.local/share/wallpapers\
		[.minecraft]=${USERDATADIR}.minecraft\
		[.mozilla]=${USERDATADIR}.mozilla\
		[.netrc]=${USERDATADIR}.netrc\
		[.npmrc]=${USERDATADIR}.npmrc\
		[.purple]=${USERDATADIR}.purple\
		[.ssh]=${USERDATADIR}.ssh\
		[.wine]=${USERDATADIR}.wine\
	)

# link to the configuration files and directories in the dotfiles repository
declare -A USERDOTFILES=(\
		[.bash_aliases]=${DOTFILESDIR}bash_aliases\
		[.bashrc]=${DOTFILESDIR}bashrc\
		[.gitconfig]=${DOTFILESDIR}gitconfig\
		[.gvimrc]=${DOTFILESDIR}gvimrc\
		[.hgrc]=${DOTFILESDIR}hgrc\
		[.inputrc]=${DOTFILESDIR}inputrc\
		[.profile]=${DOTFILESDIR}profile\
		[.vim]=${DOTFILESDIR}vim\
		[.vimrc]=${DOTFILESDIR}vimrc\
		[.dir_colors]=${DOTFILESDIR}dircolors.ansi-dark\
		[.local/share/konsole/Solarized\ Dark.colorscheme]=${DOTFILESDIR}local/share/konsole/Solarized\ Dark.colorscheme\
		[.local/share/konsole/Solarized\ Light.colorscheme]=${DOTFILESDIR}local/share/konsole/Solarized\ Light.colorscheme\
		[.local/share/konsole/Solarized\ MJL.colorscheme]=${DOTFILESDIR}local/share/konsole/Solarized\ MJL.colorscheme\
	)

pushd /home/${USER}

mkdir -p userdata_backup/config
echo Moving existing files to backup location...

if [ $LINKUSERDATAFILES = true ]; then
    mv --verbose --backup=numbered --t userdata_backup/ "${!USERDIRS[@]}"
    mv --verbose --backup=numbered --t userdata_backup/config "${!USERCONFIGFILES[@]}"
fi

if [ $LINKDOTFILES = true ]; then
    mv --verbose --backup=numbered --t userdata_backup/ "${!USERDOTFILES[@]}"
fi

if [ $LINKUSERDATAFILES = true ]; then
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
fi

if [ $LINKDOTFILES = true ]; then
    for f in "${!USERDOTFILES[@]}"
    do
        echo linking $f to ${USERDOTFILES[$f]}...
        ln -s "${USERDOTFILES[$f]}" "$f"
    done
fi

popd
