#!/bin/bash
# Add the packages I want in addition to the base Linux Mint KDE distribution

add_pkgs=`grep "^[^#]" ~/Documents/installed-packages.lst`

# add the -s option to "No-act. Perform ordering simulation"
sudo apt-get -V -q install $add_pkgs
