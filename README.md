# Settings

Contents of this folder go in `~/settings` on a Mac

## Contents
  * `.vim/` (OS X)
    * `.vimrc` (OS X, lxplus)
  * `.bashmodules/` (all)
    * `.bash_profile` (OS X)
    * `.bashrc` (lxplus, cmslpc)
  * `.rootlogon.C` (lxplus)
  * `colors.sh` (lxplus)
  * `pie.py` (lxplus, OS X)
  * `.tcshrc` (cmslpc)

`backup.sh` copies all current files and folders to `~/settings/`

  * contains a version of the `kcern` and `kfnal` functions

## Notes
### General
  * Dots should be prefixed
    * they were removed so that the files aren't hidden
  * `_mac`, `_lxplus`, and `_cmslpc` should be removed
    * they are there to disambiguate clearly
  * `.sh`, `.vim`, `.py`, etc. should be removed where applicable
    * it is there so github properly highlights syntax

### `.bashmodules/` Folder
`.bashrc` and `.bash_profile` now only source "modules" that live in `~/.bashmodules/`.
This will make it more convenient to manage different versions of bash configurations across
different operating systems and command line environments.

Each module has a different version that references a common module;
the `cern.sh` modules have an additional layer in between for commands that are specific to
Scientific Linux, and for commands that are specific to SLC and SLF.

### Kerberos Authentication
I modified `/etc/krb5.conf` on OS X so as to conveniently ssh without passwords, adding:

  * Under `[libdefaults]`:
    * `default_cc_type = FILE`; changes from API-based to FILE-based
    * `default_cc_name = /Users/Riju/.kcaches/cache`; provides credential cache file
  * Under `[domain_realm]`:
    * `cern.ch = CERN.CH`

macOS 10.12 (Sierra): Apple removed GSSAPI authentication so
  * `/etc/ssh/ssh_config`: added `XAuthLocation /opt/X11/bin/xauth`
  * Replaced the `ssh` program by adding it to `~/usr/bin/local/`
  * for OpenSSH 7.1 : Commented out most of my `~/.ssh/config`

### `.vim/` Folder and `.vimrc`
#### `.vimrc`
`.vimrc` sets the following:

  * Filetype plugin indentation is on
  * Syntax highlighting is on
  * Tabs are set to 4 spaces
  * Highlight search and status bar are on
  * TeX files
    * Tabs are 2 spaces
    * Several shortcuts and additional settings are defined
  * Python files
    * Experimenting with visualizing indents (for long blocks)
    * Experimenting with adding to the color syntax (e.g. coloring `eprint`)

#### `.vim/`
  * Contains the [VIM-LaTeX](http://vim-latex.sourceforge.net/) plugin
    * The "change environment" macro has been slightly changed to prevent extra `\` characters.
    * [ ] To do: I probably need to make a similar change to the "change command" macro
  * Contains plugin files for my own `.note` files: `colors`, `ftdetect`, and `syntax`
  * Modifies the 2014 default python.vim by adding a `setlocal noexpandtab` to `~/.vim/after/ftplugin/python.vim`

#### Other
`.rootlogon.C` is my ROOT configuration file. It needs to be updated...

Since it is either impossible or inconvenient to change the default shell on CMSLPC,
`.tcshrc` executes `bash` and drops out, so that I don't have to log out twice, BUT only
for interactive shells, so that scp doesn't fail.

`colors.sh` prints a helpful ANSI SGR color code matrix

  * On OS X, run `macColors.sh` first to produce a Mac-compatible `colors.sh`

`pie.py` wraps `du` with a visual bar chart breakdown of the files in the current folder  
It takes the following optional arguments:

  * `-m` the max number of boxes (e.g. 10, 50, 100)
  * `-H` turn off human readable sizes (e.g. 1K, 5M)
  * `-b` (Linux only) print disk usage instead of apparent size
