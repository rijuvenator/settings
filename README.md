# Settings

Contents of this folder go in `~/settings` on a Mac

Contains:
  * `.vimrc` (OS X, lxplus)
  * `.bash_profile` (OS X, lxplus)
  * `.vim/` (OS X)
  * `.rootlogon.C` (lxplus)

Notes:
  * Dots should be prefixed
    * they were removed so that the files aren't hidden
  * `_mac`, `_lxplus`, and `.sh` should be removed if applicable
    * `_mac` and `_lxplus` disambiguate clearly; `.sh` makes github properly highlight syntax

The `.vim/` folder contains the [VIM-LaTeX](http://vim-latex.sourceforge.net/) plugin.
  * The "change environment" macro has been slightly changed to prevent extra `\` characters.
  * [ ] To do: I probably need to make a similar change to the "change command" macro

`backup.sh` copies all current files and folders to `~/settings/`
