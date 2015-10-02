# Settings

Contents of this folder go in `~/settings` on a Mac

Contains:
  * `.vimrc` (OS X, lxplus)
  * `.bash_profile` (OS X, lxplus)
  * `.vim/` (OS X)
  * `.rootlogon.C` (lxplus)

Dots should be prefixed and `_mac` and `_lxplus` should be removed, if applicable

The `.vim/` folder contains the [VIM-LaTeX](http://vim-latex.sourceforge.net/) plugin.  
The "change environment" macro has been slightly changed to prevent extra `\` characters.
  * [ ] I probably need to make a similar change the "change command" macro

`backup.sh` copies all current files and folders to `~/settings/`
