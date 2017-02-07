# Settings

Contents of this folder go in `~/settings` on a Mac

Contains:
  * `.vimrc` (OS X, lxplus)
  * `.bash_profile` (OS X)
  * `.vim/` (OS X)
  * `.rootlogon.C` (lxplus)
  * `colors.sh` (lxplus)
  * `.bashrc` (lxplus, cmslpc)
  * `.tcshrc` (cmslpc)
  * `pie.py` (lxplus, OS X)

Notes:
  * Dots should be prefixed
    * they were removed so that the files aren't hidden
  * `_mac`, `_lxplus`, and `_cmslpc` should be removed
    * they are there to disambiguate clearly
  * `.sh` should be removed where applicable
    * it is there so github properly highlights syntax

Fermilab SLF6 Cluster Notes:
  * `.vimrc` and `.rootlogon.C` are the same as for lxplus, so no copies
  * `.bashrc` for cmslpc is the same as for lxplus, except it
    * executes the `cmsset` script so as to allow use of `scram` and `cmsenv`
    * defines lxplus instead of cmslpc aliases; doesn't define `d3` or `EOSFNAL`
    * defines a `condor_s` status formatting function
  * `.tcshrc` for cmslpc executes `bash` (and drops `tcsh`) *if not interactive*
    * in place of a simple `exec bash`, so that `scp` doesn't break

Kerberos Authentication Notes:
I modified `/etc/krb5.conf` on OS X so as to conveniently ssh without passwords, adding:
  * Under `[libdefaults]`:
    * `default_cc_type = FILE`; changes from API-based to FILE-based
    * `default_cc_name = /Users/Riju/.kcaches/cache`; provides credential cache file
  * Under `[domain_realm]`:
    * `cern.ch = CERN.CH`

The `.vim/` folder contains the [VIM-LaTeX](http://vim-latex.sourceforge.net/) plugin.
  * The "change environment" macro has been slightly changed to prevent extra `\` characters.
  * [ ] To do: I probably need to make a similar change to the "change command" macro

`backup.sh` copies all current files and folders to `~/settings/`
  * contains a version of the `kcern` and `kfnal` functions

`colors.sh` prints a helpful ANSI SGR color code matrix
  * On OS X, run `macColors.sh` first to produce a Mac-compatible `colors.sh`

`pie.py` wraps `du` with a visual bar chart breakdown of the files in the current folder
  * takes one argument, the max number of boxes (e.g. 10, 50, 100)
