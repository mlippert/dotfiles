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
- Should block snap Firefox and install PPA instead.  
  see https://ubuntuhandbook.org/index.php/2022/04/remove-snap-block-ubuntu-2204/  
  and https://linuxiac.com/install-firefox-from-deb-on-ubuntu-22-04-lts/  
  and https://balintreczey.hu/blog/firefox-on-ubuntu-22-04-from-deb-not-from-snap/  
  This is now being done (_I think_) by the playbook

    ```
    sudo snap remove --purge firefox
    sudo add-apt-repository ppa:mozillateam/ppa
    cat <<END | sudo tee /etc/apt/preferences.d/firefox-no-snap > /dev/null
    Package: firefox*
    Pin: release o=Ubuntu*
    Pin-Priority: -1
    END
    ```

- add 2 ppas (the 2nd updates plasma to 5.25)
  - sudo add-apt-repository ppa:kubuntu-ppa/backports
  - sudo add-apt-repository ppa:kubuntu-ppa/backports-extra && sudo apt full-upgrade -y

#### apt ppa keys (dealing w/ DEPRECATION message)

See https://askubuntu.com/questions/1286545/what-commands-exactly-should-replace-the-deprecated-apt-key
and see https://askubuntu.com/questions/1403556/key-is-stored-in-legacy-trusted-gpg-keyring-after-ubuntu-22-04-update
for how to export from the apt trusted keyring rather than re-downloading the keys



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

### From mlippert [dotfiles wiki](https://github.com/mlippert/dotfiles/wiki/New-Computer-Install)

**TODO**: _Should be better integrated with the other notes here -mjl 2023-03-15_

Some of this will be incorporated into ansible playbook tasks.

#### Mouse wheel scroll amount
Found [this](https://www.reddit.com/r/kde/comments/id6nzg/any_way_to_increase_mouse_scroll_speed/) which suggested adding the `WheelScrollLines` to the `[KDE]` section of `~/.config/kdeglobals`.
I think the default value is 3, which is a little too much and 1 is too slow, I found 2 to work well for me.
Also note you can add the same section to `~/.config/dolphinrc` if you want it to scroll differently in Dolphin.

```
[KDE]
WheelScrollLines=2
```

#### Adding PPA repositories
The existing tools to add Ubuntu PPA repositories, `add-apt-repository` and `apt-key` are now deprecated.
But I have not found any good instructions on what to do instead of using those tools.

The basic issue is that the repository signing key should be applied ONLY for the repository it
is meant for, and the tools add it to the apt trusted keyring which would let it be used for ANY
repository.

My 1st pass at fixing this is to extract each key into an individual keyring file stored in `/etc/apt/keyrings/`.
This approach still uses `add-apt-repository` to do the initial setup, creating a apt source list file in
`/etc/apt/sources.list.d/` and usually adding the key to the `/etc/apt/trusted.gpg` keyring.

My 2nd attempt is to use `gpg` directly to download the key into `/etc/apt/keyrings/`. To do this I
got the key fingerprint from the PPA page on launchpad.net, e.g. `https://launchpad.net/~jonathonf/+archive/ubuntu/vim`.
Under _Technical details about this PPA_ it lists the signing key fingerprint `4AB0F789CBA31744CC7DA76A8CF63AD3F06FC659`
for the example.

```
cd /etc/apt/keyrings
sudo gpg --no-default-keyring --keyring=./jonathonf-vim-ppa.gpg --keyserver=hkps://keyserver.ubuntu.com --recv-keys 4AB0F789CBA31744CC7DA76A8CF63AD3F06FC659
```

Then edit /etc/apt/sources.list.d/ppa_jonathonf_vim_jammy.list and add the `[signed-by=...]` section shown here

```
deb [signed-by=/etc/apt/keyrings/jonathonf-vim-ppa.gpg] http://ppa.launchpad.net/jonathonf/vim/ubuntu jammy main
# deb-src [signed-by=/etc/apt/keyrings/jonathonf-vim-ppa.gpg] http://ppa.launchpad.net/jonathonf/vim/ubuntu jammy main
```

additionally if the PPA is using `http` and `launchpad.net` it would be worthwhile changing it to use `https` and
`launchpadcontent.net`

```
deb [signed-by=/etc/apt/keyrings/jonathonf-vim-ppa.gpg] https://ppa.launchpadcontent.net/jonathonf/vim/ubuntu jammy main
# deb-src [signed-by=/etc/apt/keyrings/jonathonf-vim-ppa.gpg] https://ppa.launchpadcontent.net/jonathonf/vim/ubuntu jammy main
```

Note that in order to run gpg w/ sudo, I had to create a `.gnupg` directory in /root and set its permissions to `u=rwx,g=,o=`

#### New DEB822 format for apt sources

see https://discourse.ubuntu.com/t/spec-apt-deb822-sources-by-default/29333

so we could convert the vim PPA `sources.list.d/ppa_jonathonf_vim_jammy.list` file above to
`sources.list.d/ppa_jonathonf_vim_jammy.source`:

```
Types: deb
URIs: https://ppa.launchpadcontent.net/jonathonf/vim/ubuntu
Suites: jammy
Components: main
Signed-By: /etc/apt/keyrings/jonathonf-vim-ppa.gpg
```
