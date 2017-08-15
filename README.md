# dotfiles

## Setup For Ubuntu

1. Install `git`, `xsel`, `vim` (`sudo apt-get install git xsel vim`)
2. Install keepassxc (`sudo snap install keepassxc`)

## Setup For Arch

## Setup For Mac

1. Install Homebrew, Xcode
2. From Homebrew (cask), install:
    - iterm2
    - ~~karabiner-elements~~ (not needed since Sierra, see System Preferences -> Keyboard -> Modifier Keys)
    - keepassxc
    - spectacle
    - firefox
    - google-chrome
    - bash 4 (http://blog.pivotal.io/labs/labs/cdpath-bash-completion-in-osx)
    - vim (+jq, +w3m, +editorconfig for plugins)
    - kakoune (see https://github.com/mawww/kakoune#installing, +jq, +gogetdoc, +gometalinter, +ranger, +highlight for plugins)
    - git
    - direnv
3. Create ssh keys for github, bitbucket, etc. (https://blog.g3rt.nl/upgrade-your-ssh-keys.html)
4. Clone mna/dotfiles, install
5. Clone mna/myvim into ~/.vim/
6. Clone powerline/fonts, install, setup in iTerm2 (note the non-ascii font tweak mentioned in the readme)
7. Clone jimeh/git-aware-prompt

## Configure Firefox

1. Customize to remove bloat
2. Install add-on VimFx
3. Install add-on Instapaper
