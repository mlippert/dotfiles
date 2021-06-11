# dotfiles ansible playbooks

## mjl-user.yml

This playbook is to initialize the settings for the mjl user on a new install of Kubuntu 20.04

In that scenario a few pre-requisites must be installed first. Here are they are:

Some of these may be easier to set up because they are already partially there on an existing
`userdata` partion.

1. add userdata partition to `/etc/fstab`1. this dotfiles repository
    1. Install git from the standard OS repo -- `sudo apt install git`
    1. clone https://github.com/mlippert/dotfiles.git in /userdata/mjl/dotfiles
1. Latest python, currently python 3.9
	1. From https://phoenixnap.com/kb/how-to-install-python-3-ubuntu
        1. Add Deadsnakes PPA
		    sudo add-apt-repository ppa:deadsnakes/ppa
        1. sudo apt update
        1. sudo apt install python3.9 python3.9-venv
1. Install the python virtual env for ansible

    ```
    cd /userdata/mjl/dotfiles/ansible
    make install VER=3.9
    ```
1. Run the `mjl-user.yml` ansible playbook

    ```
    cd /userdata/mjl/dotfiles/ansible
    . activate
    ansible-playbook mjl-user.yml --ask-become-pass --check
    ansible-playbook mjl-user.yml --ask-become-pass
    ```

## After running mjl-user.yml playbook

1. git  
    Best option is to use the Project/public/git repo a clone of git://git.kernel.org/pub/scm/git/git.git
	1. `make clean`
	1. _move/set_ `installed` branch to latest version tag
	1. `make prefix=/usr/local all doc info`
	1. `sudo make prefix=/usr/local install install-doc install-html install-info`


## Notes

From 18.04 settings for now
On my laptop I bumped up the System Settings Font sizes by 1 point, from 10, 9, 8, 10, 10 10 to 11, 10, 9, 11, 11, 11

- Workspace Theme:
    - Look And Feel: Kubuntu
    - Desktop Theme: Oxygen
    - Cursor Theme: Breeze
    - Splash Screen Breeze
- Colors: Oxygen Cold
- Icons: Oxygen
- Application Style:
    - Widget Style: QtCurve
    - Window Decorations: Breeze
    - GNOME Application Style (GTK)
        - GTK2 Theme: QtCurve
        - GTK3 Theme: Adwaita
        - Icon Theme: Oxygen
