# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep nomatch
unsetopt notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/martin/.zshrc'

autoload -Uz compinit && compinit
# End of lines added by compinstall
#

# load aliases
[[ -e ~/.config/zsh/.zsh_aliases ]] && source ~/.config/zsh/.zsh_aliases

autoload -U promptinit && promptinit
autoload -U colors && colors
PS1="%B%n@%m%b: %{$fg[magenta]%}%3(~|.../|)%2~%{$reset_color%} %(?..%{$fg[red]%}(%?%) %{$reset_color%})%B%{$fg[blue]%}%#%{$reset_color%}%b "
# add git to prompt (right-hand)
source ~/.config/zsh/.zshgit

# enable ctrl-x i to type unicode characters
autoload insert-unicode-char
zle -N insert-unicode-char
bindkey '^Xi' insert-unicode-char

# search in history with arrow-up and down
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

bindkey '^R' history-incremental-search-backward
bindkey "^H" backward-delete-char

# custom functions
fpath=(~/.config/zsh/functions $fpath)
autoload -Uz $(ls ~/.config/zsh/functions)

# avoid screen freeze with ctrl-s
stty -ixon
