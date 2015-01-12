# Helpful information about linux that I have looked up #
<p style="font-size: 80%; text-align: center;">
Mike Lippert<br/>
last edited on August 17, 2013
</p>

## kde ##
Dolphin context menus are called service menus, they are implemented with .desktop files
that are also used for the main KDE application launcher. I found a very helpful
[tutorial page][menuTutorial] on these .desktop files.

[menuTutorial]: <http://techbase.kde.org/Development/Tutorials/Creating_Konqueror_Service_Menus>

### wifi networking ###
Setting the wifi password for all users requires superuser privileges which the KDE plasma applet doesn't have (at least not in Linux Mint). I suspect that is why the checkbox option _all users may connect to this network_ isn't present.
This archlinux page on [NetworkManager][] is helpful, and I was able to accomplish setting the password for all users using the commandline.

```
sudo nmcli dev wifi connect <SSID> password <WIFI-PSWD>
```

[NetworkManager]: <https://wiki.archlinux.org/index.php/NetworkManager>

## bash ##
* bash scripts normally start w/ a [shebang][] (```#!```), in fact just use ```#!/bin/sh``` to indicate
  that the default shell (bash on linux) should be used to execute the script. Or you could specify
  that bash should be used w/ ```#!/bin/bash```. [responses on linuxquestions][shebang2]
* To [grep through only stderr][stkovrflw-redirect] redirect stderr to stdout and stdout to null:  
  ```command 2>&1 >/dev/null | grep 'something'```  
  Note that the order matters, if you want to just combine the 2 and redirect them both to a file:  
  ```command >outfile 2>&1```

### References ###
* [Bash Reference Manual][BashManual]
* These may also be useful references, I haven't really read much of them yet (8/2013):  
  [Advanced Bash-Scripting Guide][AdvBash]  
  [BASH Programming - Introduction HOW-TO][IntroBash]

[BashManual]: <http://www.gnu.org/software/bash/manual/bashref.html> "Gnu Bash Manual"
[shebang]: <http://en.wikipedia.org/wiki/Shebang_%28Unix%29> "Wikipedia shebang entry"
[shebang2]: <http://www.linuxquestions.org/questions/linux-newbie-8/bash-script-line1-bin-sh-what-does-it-mean-200542/>
[AdvBash]: <http://www.tldp.org/LDP/abs/html/>
[IntroBash]: <http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html>
[stkovrflw-redirect]: <http://stackoverflow.com/questions/2342826/how-to-pipe-stderr-and-not-stdout>

## vim ##
* find the filetype: ```:set filetype?``` or ```:se ft?```
* goto previous location ```Ctrl-O``` and back again with ```Ctrl-I```  
  see <http://stackoverflow.com/questions/11018713/vim-go-to-previous-location>
  or ```:help jumplist```
* word wrap text (respects comment indentation): set ```textwrap``` and then use ```gq<movement>``` (or use visual mode w/ `gq`)  
  see [stackoverflow question](http://stackoverflow.com/questions/3033423/vim-command-to-restructure-force-text-to-80-columns/16539475#16539475)
* Highlight all search pattern matches: ```:set hlsearch```, to disable for current search
  use ```:nohlsearch``` or ```:noh``` which removes the highlighting for the current search.  
  see <http://vim.wikia.com/wiki/VimTip14>
* Use ```*``` to search forward for word under cursor (or visual selection) and ```#```
  to search backwards.
* [How to paste text into vim command line and elsewhere](http://stackoverflow.com/questions/3997078/how-to-paste-text-into-vim-command-line)
* Use `ctrl-R ctrl-W` to paste the word under the cursor into the command line. [How do I specify “the word under the cursor” on VIM's commandline?](http://stackoverflow.com/questions/48642/how-do-i-specify-the-word-under-the-cursor-on-vims-commandline)
* folding lines [help 1](http://www.linux.com/learn/tutorials/442438-vim-tips-folding-fun) [help 2](http://vim.wikia.com/wiki/Folding)

### plugins ###
actually, I have much more info in the readme in my dotfiles github repository, which
currently only contains my vim dotfiles. (7-23-2013)

### how to... ###

* insert from a command  
  for example to get a quoted comma separated list of js files use: ```:r ! ls -mQ *.js```  
  for more general info see [Vim tips: Working with external commands][VimTipsECmds]

* [Using vi as a hex editor][viHexEdit] - The key to this isn't so much about editing as viewing
  which doesn't even really have to involve vim. Use the [xxd][] utility to create the typical
  hex/text dump display.

[VimTipsECmds]: <https://www.linux.com/learn/tutorials/442419-vim-tips-working-with-external-commands>
[viHexEdit]: <http://www.kevssite.com/2009/04/21/using-vi-as-a-hex-editor/>
[xxd]: <http://linuxcommand.org/man_pages/xxd1.html>

## general linux ##
info on things like users, groups, fstab, samba, nfs.

* the medibuntu repository is no more. [According to the maintainer][medibuntu-gone] all of
  its packages are now in the main ubuntu repositories, except for libdvdcss. It is available
  in a [repository][videolan-repo] hosted by [VideoLAN][videolan-host]. The post explains
  how to add the repo where that package is now maintained. I found the post mentioned above
  from [this one][medibuntu-gone2].

- There's an issue w/ gnutls which is used by git that is causing an error accessing remote repos using https:
  [GnuTLS recv error (-9)][]
    - the solution seems to be to uninstall `libcurl4-gnutls-dev` and install `libcurl4-openssl-dev`
	  and then rebuild git

[medibuntu-gone]: <http://gauvain.pocentek.net/node/61>
[medibuntu-gone2]: <http://www.rfc3092.net/2013/10/r-i-p-medibuntu/>
[videolan-repo]: <ftp://ftp.videolan.org/pub/debian>
[videolan-host]: <http://blogs.kde.org/2013/09/11/medibuntu-disappear-libdvdcss-now-direct-videolan>
[GnuTLS recv error (-9)]: <http://stackoverflow.com/questions/13524242/error-gnutls-handshake-failed-git-repository>

### Potentially useful articles on the web ###
[Using Git and Github to Manage Your Dotfiles](http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/)

## [npm][] ([node][] package manager) ##
The version of nodejs in the ubuntu repositories is dated. Use these instructions
for [Installing Node.js via package manager][install-nodejs].

The Ubuntu repositories as of 14.04 have the latest nodejs. However because of a potential
conflict it is installed as `nodejs` instead of `node`. Since we have no use for the conflicting
node application add a symlink: `sudo ln -s /usr/bin/nodejs /usr/bin/node`

Installing npm (```apt-get install npm```) will install node.js as a dependency.

use ```npm list``` to see locally installed npm packages and ```npm list -g``` to see
globally installed packages.

[http-server](https://npmjs.org/package/http-server) a simple zero-configuration command-line http server

[npm]: <https://npmjs.org/>
[node]: <http://nodejs.org/>
[install-nodejs]: <https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager#ubuntu-mint-elementary-os>

## Chromium ##
I installed the [Markdown Preview 0.6][markdownExt] extension from Boris Smus to be able to render markdown files like this one.
Don't forget to check *Allow access to file URLs*.

[markdownExt]: <https://chrome.google.com/webstore/detail/markdown-preview/jmchmkecamhbiokiopfpnfgbidieafmd>

* * *
This readme is in [markdown syntax](http://daringfireball.net/projects/markdown/syntax).

## Firefox ##
To get the OK button on the left of the cancel button [this forum topic from 2004](http://forums.gentoo.org/viewtopic.php?t=139596&) is helpful. What it says is edit the `userChrome.css`
file (if it doesn't exist it create it in the firefox chrome/ subfolder) and add the following lines:

    .dialog-button-box { -moz-box-direction: reverse; -moz-box-pack: right; }
    .dialog-button-box spacer { display: none !important; }

installing the qtcurve package and setting the gtk+ appearance theme to qtcurve may also help.

## Setting up a new release ##
Updating to the latest Linux Mint means re-installing. A fresh install is welcome,
but it takes a while to get the environment settings back to _just so_.

I'm trying to keep a record here of what those setting are so that I can just run
through the list and I'll be mostly ready to go.

### System Settings ###
1. Turn on 2 virtual desktops in Workspace Behavior
2. In System Notifications turn on Play a sound for _KDE Workspace_ _Logout_ and _Login_

### in a VirtualBox VM ###
The article [Creating Shared Drives in Oracle VM VirtualBox][VBSharedDrives], describes how to create a shareable virtual disk.  
Assuming it already exists, add the SharedStorate/UserData1Ext4.vdi to SATA Port 1.  
You may need the command:

```
    "\path-to-VB\VBoxManage" storageattach "Linux Mint 15 KDE" --storagectl "SATA" --port 1 --device 0 --type hdd --medium UserData1Ext4.vdi --mtype shareable
```

[VBSharedDrives]: <http://www.oracledistilled.com/virtualbox/creating-shared-drives-in-oracle-vm-virtualbox/>

1. Create the /userdata directory as a mount point
2. Edit fstab and add: (the uuid is from the UserData1Ext4 created for my home VirtualBox)  

```
    UUID=9ac7eda0-0b5b-47bd-ae44-fdf53dd6868a /userdata       ext4    errors=remount-ro 0       1
```

3. Remove the repository versions of the VirtualBox Guest Additions (3 packages dkms, x11 and utils)
4. Install the guest additions from the VirtualBox Host install.


### Dolphin configuration settings ###
* Startup: check Editable location bar
* View Modes Details: set both default and preview Icon size to 1 step above smallest
* General Behavior: select Use common properties for all folders
* Then change to display details, and set the zoom to 22 pixels
* Add permissions, owner and group columns
* Add Folders panel (from View menu)


### KDE bottom panel ###
1. Right-click on the launcher and _Switch to Classic Menu Style_
2. Add the following widgets:
    * QuickLaunch
    * Pager
    * Lock/Logout
3. Add the following launchers to the QuickLaunch
    * Synaptic Package Manager
    * Konsole
3. Remove the Dolphin icon
4. Lock the Widgets on the bottom panel

### Create symbolic links from new home directory to userdata home files and folders ###

### Additional repositories ###
See above for adding the ```node``` repository.
pidgin repo?
scootersoftware repo?

#### Oracle Java 8 (JDK 8) ####
See the [TecAdmin.net Java 8 instructions][java8repo] for installing the webupd8team's PPA repository and installing Java 8 from there.

[java8repo]: <http://tecadmin.net/install-oracle-java-8-jdk-8-ubuntu-via-ppa/#>

### packages ###
These are the packages that were not installed in the last release of Linux Mint KDE that I always want installed. I keep the list in the file ```installed-packages.lst```.

There are some packages (such as for licensed software) that needs to be downloaded and then installed.
* ScooterSoftware's Beyond Compare (they've got a repo that can be used)
* SmartGit (needs git installed 1st)
* jq

### Rebuild software from sources ###
* git (use prefix=/usr/local
* KeePassX

