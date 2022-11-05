# dotfiles ansible playbooks

## mjl-user.yml

This playbook is to initialize the settings for the mjl user on a new install of Kubuntu 22.04 (Jammy Jellyfish)

In that scenario a few pre-requisites must be installed first. Here are they are:

Some of these may be easier to set up because they are already partially there on an existing
`userdata` partion.

1. add userdata partition to `/etc/fstab`
2. this dotfiles repository
   1. Install git from the standard OS repo -- `sudo apt install git`
   2. Install make from the standard OS repo -- `sudo apt install make`
   3. clone https://github.com/mlippert/dotfiles.git in /userdata/mjl/dotfiles

3. Latest python, currently python 3.10
   1. From https://phoenixnap.com/kb/how-to-install-python-3-ubuntu
      1. Add Deadsnakes PPA  
         sudo add-apt-repository ppa:deadsnakes/ppa
      2. sudo apt update
      3. sudo apt install python3.10 python3.10-venv
4. Install the python virtual env for ansible

    ```
    cd /userdata/mjl/dotfiles/ansible
    make install VER=3.10
    ```

5. Currently the bin/hookup_userdata_links.sh is not integrated into ansible so it should be run now.
 
6. Create `~/tmp` directory

7. Manually install from the list of `software_other_install_methods` in the playbook

8. Run the `mjl-user.yml` ansible playbook

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
   2. _move/set_ `installed` branch to latest version tag
   3. `make prefix=/usr/local all doc info`
   4. `sudo make prefix=/usr/local install install-doc install-html install-info`

### Various other changes that aren't yet done by ansible

1. dolphin
   1. show on menubar
   2. sorting mode: alphabetical, case sensitive
   3. set details preview icon size to 1 above minimum
   4. switch to details view mode
   5. add columns type, permissions, owner, group
   6. show folders panel
   7. add to places _Root_ with icon set to folder-root-symbolic
   8. turn off for the home folder "Limit to Home Directory"
2. konsole
   1. create a new profile _KDE Initial_ w/ no changes
   2. create a new profile _MJL`
      - set initial terminal size to 140 col 30 rows
      - set Appearance to _Solarized MJL_
      - set font to Hack 10pt (+1 from default)
      - set scrollback to fixed 2000 lines
   3. set MJL profile as default
   4. set Tab Bar
      - set show to always
      - set _show close tab button_ to none
3. Desktop
   1. On bottom panel add widgets
      - Quicklaunch (add these launchers from left to right)
        - Synaptic
        - Win7 VM
        - Firefox
        - dolphin
        - konsole
        - smartgit
      - Lock/Logout

## Notes

### From 18.04 settings for now

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

### From 20.04 on my Desktop

- Global Theme: Kubuntu
- Plasma Style: Oxygen
- Application Style:
  - Application Style: Oxygen
    - GTK2 theme: Adwaita (`apt install adwaita-qt gnome-themes-extra adwaita-icon-theme-full`)
    - GTK3 theme: Adwaita
  - Window Decorations: Breeze
    - Set window border size: Normal
- Colors: Oxygen Cold
- Fonts: On my laptop I bumped up the System Settings Font sizes by 1 point, from 10, 9, 8, 10, 10 10 to 11, 10, 9, 11, 11, 11
- Icons: Oxygen
- Cursors: Breeze
- Startup and Shutdown:
  - Login Screen (SDDM): Sugar Candy (1.6)
- Workspace Behavior
  - Screen Edges
    - turn off maximize and tile
    - set top left corner to no action
  - Virtual Desktops (3) 1 rows
    - Desktop 1
    - Desktop 2
    - VM
- Notifications Application Configure
  - System Services | Plasma Workspace Configure
    - Login enable sound
    - Logout enable sound

#### disable automatic updates

Edit /etc/apt/apt.conf.d/20auto-upgrades

change these from 1 to 0

```
APT::Periodic::Unattended-Upgrade "1";
APT::Periodic::Download-Upgradeable-Packages "1";
```

### Kubuntu 22.04 jammy jellyfish

very rough 1st impression notes:

- change icon-only taskmanager to one w/ text
- unpin many pinned icons from taskmanager
- !!! KRunner is getting invoked by typing on the desktop AND there is no way to disable that YET,
  supposedly a config setting has been added in a later version. I should determine which version.
- Should block snap Firefox and install PPA instead. see https://ubuntuhandbook.org/index.php/2022/04/remove-snap-block-ubuntu-2204/
  and https://linuxiac.com/install-firefox-from-deb-on-ubuntu-22-04-lts/
  and https://balintreczey.hu/blog/firefox-on-ubuntu-22-04-from-deb-not-from-snap/
- add 2 ppas (the 2nd updates plasma to 5.25)
  - sudo add-apt-repository ppa:kubuntu-ppa/backports
  - sudo add-apt-repository ppa:kubuntu-ppa/backports-extra && sudo apt full-upgrade -y

### From 22.04 on my Laptop

- Global Theme: Kubuntu
- Plasma Style: Oxygen
- Application Style:
  - Application Style: Oxygen
    - GTK theme: Adwaita (`apt install adwaita-qt gnome-themes-extra adwaita-icon-theme-full`)
  - Window Decorations: Breeze
    - Set window border size: Normal
- Colors: Oxygen Cold
- Fonts: On my laptop I bumped up the System Settings Font sizes by 1 point, from 10, 9, 8, 10, 10 10 to 11, 10, 9, 11, 11, 11
- Icons: Oxygen
- Cursors: Breeze
- Startup and Shutdown:
  - Login Screen (SDDM): Sugar Candy (1.6)
- Workspace Behavior
  - Screen Edges
    - turn off maximize and tile
    - set top left corner to no action
  - Virtual Desktops (3) 1 rows
    - Desktop 1
    - Desktop 2
    - VM
- Notifications Application Configure
  - System Services | Plasma Workspace Configure
    - Login enable sound
    - Logout enable sound

### GPG

[reddit thread on gpg](https://www.reddit.com/r/archlinux/comments/o5rcs6/psa_you_need_to_update_your_keyserver/)
says that old keyservers have been deprecated and recommends updating `gpg.conf` to
specify `keyserver hkp://pgp.mit.edu:11371`.

### Swappiness (see below link)

this should be added to the scripts because swapping is happening w/ 8GB of free RAM. (now on 20.04)

Added at the bottom of `/etc/sysctl.conf`

```
# Added by mjl on 2022-05-13 from https://askubuntu.com/a/157809/217789
vm.swappiness=10
```
