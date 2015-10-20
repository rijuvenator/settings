# Settings

Contents of this folder go in `~/settings` on a Mac

Contains:
  * `.vimrc` (OS X, lxplus)
  * `.bash_profile` (OS X, lxplus)
  * `.vim/` (OS X)
  * `.rootlogon.C` (lxplus)
  * `colors.sh` (lxplus)
  * `.bashrc` (cmslpc)
  * `.tcshrc` (cmslpc)

Notes:
  * Dots should be prefixed
    * they were removed so that the files aren't hidden
  * `_mac`, `_lxplus`, and `_cmslpc` should be removed
    * they are there to disambiguate clearly
  * `.sh` should be removed where applicable
    * it is there so github properly highlights syntax

Fermilab SLF6 Cluster Notes:
  * `.vimrc` and `.rootlogon.C` are the same as for lxplus, so no copies
  * `.bashrc` for cmslpc is the same as `.bash_profile` for lxplus, except it
    * defines a `cmsset` command that sources a script so as to allow use of `scram` and `cmsenv`
    * doesn't define cmslpc logon aliases (obviously)
  * `.tcshrc` for cmslpc executes `bash` (and drops `tcsh`) *if not interactive*
    * in place of a simple `exec bash`, so that `scp` doesn't break

The `.vim/` folder contains the [VIM-LaTeX](http://vim-latex.sourceforge.net/) plugin.
  * The "change environment" macro has been slightly changed to prevent extra `\` characters.
  * [ ] To do: I probably need to make a similar change to the "change command" macro

`backup.sh` copies all current files and folders to `~/settings/`

`colors.sh` prints a helpful ANSI SGR color code matrix
  * On OS X, run `macColors.sh` first to produce a Mac-compatible `colors.sh`
