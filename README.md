dotfiles
========

This repository contains all of the _dotfiles_ that I've configured and want to
both backup AND be able to easily transfer to a new machine (install).

Many thanks to Michael Smalley for his blog post [Using git and Github to manage your Dotfiles][manageDotfiles]

[manageDotfiles]: <http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/>

I've set the .gitignore to ignore ALL files, so that I can pick and choose which files are actually
added to the repository. I don't want config files w/ passwords or license keys in the clear to be
in this repository.

I've added a `bin` subdirectory for those useful shell scripts that I'd like to have readily available on new systems. Some are useful as is, but many are still works in progress, some need to be customized to the new system and some are just templates that demonstate how to do something in a bash script so I don't have to re-research it.

I'm working on a script that will back up the existing dotfiles and then replace them w/ symlinks to the files in this repo, but it's still rough.

## dircolors ##

These files are meant to be linked to `~/.dir_colors`.
The `dircolors.ansi-dark` and `dircolors.ansi-dark` files are intended to work w/ a terminal setup w/ a Solarized color palette. I got them from the [dircolors-solarized][] github repository.

They should work with the konsole solarized color scheme files in `kde/share/apps/konsole` which came from the [konsole-colors-solarized][] github repository.

[dircolors-solarized]: <https://github.com/seebi/dircolors-solarized>
[konsole-colors-solarized]: <https://github.com/phiggins/konsole-colors-solarized>
