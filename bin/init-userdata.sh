#!/bin/bash
# Create directories in userdata/<user> that hookup_userdata_links.sh will create symlinks to

USER=mjl

if [ -n "$1" ]; then
    USER=$1
fi

if ! pushd /userdata/${USER}; then
    exit 1
fi

# TODO: We really need to create all of these as the user $USER so they have the correct permissions

mkdir .aws .beyondcompare .dia .docker .gnupg .gramps .minecraft .mozilla .purple .smartgit .ssh .thunderbird .var .wine
mkdir Documents Downloads Music Pictures Videos bin
touch .netrc .npmrc
chmod go= .gnupg

mkdir .config
pushd .config
mkdir 'ReText project' bcompare bcompare5 calibre discord keepassxc libreoffice smartgit teamviewer ukuu
touch KeePassXCrc
popd

mkdir -p .local/share
pushd .local/share
mkdir icons smartgit task wallpapers
popd

popd
