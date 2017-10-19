# dotfiles

## Setup For Ubuntu

1. Install `git`, `xsel`, `vim`, `direnv`, `ag` (`sudo apt-get install git xsel vim direnv silversearcher-ag`)
2. Install `keepassxc` (`sudo snap install keepassxc`)
3. Install `go` (`sudo snap install --classic go`)
4. If installing on Mac, fix the missing backtick/tilde key (https://askubuntu.com/a/553174) and remap the cmd key to ctrl (https://radu.cotescu.com/remapping-keys-in-ubuntu-14.04/)
5. Create directories in ${HOME} (`mkdir {src,pkg,bin}`)
6. Create ssh keys for github, bitbucket, etc. (https://blog.g3rt.nl/upgrade-your-ssh-keys.html)
7. Clone mna/dotfiles, install
8. Clone mna/myvim into ~/.vim/
9. Clone jimeh/git-aware-prompt
10. Install vscode (https://code.visualstudio.com/docs/setup/linux)

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
    - vim (+jq, +editorconfig, +fzf, +ag for plugins)
    - kakoune (see https://github.com/mawww/kakoune#installing, +jq, +gogetdoc, +gometalinter, +ranger, +highlight for plugins)
    - git
    - direnv
3. Create ssh keys for github, bitbucket, etc. (https://blog.g3rt.nl/upgrade-your-ssh-keys.html)
4. Create directories in ${HOME} (`mkdir {src,pkg,bin}`)
5. Clone mna/dotfiles, install
6. Clone mna/myvim into ~/.vim/
7. Clone jimeh/git-aware-prompt

## Configure Firefox

1. Customize to remove bloat
2. Install add-on VimFx
3. Install add-on Instapaper

