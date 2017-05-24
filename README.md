# dotfiles

## Setup new mac

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

## Firefox

1. Install Firefox from Homebrew
2. Customize to remove bloat
3. Install add-on VimFx, Tab Center (Test Pilot)

## Kakoune

Create symbolic link to system autoload directory in local autoload directory after install, e.g.:

```
$ ln -s /usr/local/share/kak/autoload/ ~/.config/kak/autoload/
```

Run the following to install ranger config files locally:

```
$ ranger --copy-config=rc
# then remove most of it, keep just what's needed, it loads the global config too

$ ranger --copy-config=scope
```

