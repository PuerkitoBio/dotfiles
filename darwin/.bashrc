export PATH=$PATH:$HOME/bin:$HOME/src/go/bin
export GOPATH=$HOME
export N_PREFIX=$HOME
export CLICOLOR=1
export EDITOR=vim
export CDPATH=.:$GOPATH/src/github.com:$GOPATH/src/bitbucket.org:$GOPATH/src/golang.org/x
export GITAWAREPROMPT=$GOPATH/src/github.com/jimeh/git-aware-prompt

# load aliases if any
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# enable bash-completion (installed from brew, AFTER installing and
# upgrading to bash 4.x)
# http://blog.pivotal.io/labs/labs/cdpath-bash-completion-in-osx
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
fi

# enable git-aware-prompt
# https://github.com/jimeh/git-aware-prompt
if [ -f $GITAWAREPROMPT/main.sh ]; then
    source $GITAWAREPROMPT/main.sh
fi
export PROMPT_DIRTRIM=1
export PS1="\u@\h \[$txtpur\]\w\[$txtrst\] \[$bakwht\]\[$txtblk\]\$git_branch\$git_dirty\[$txtrst\] \\$\[$(tput sgr0)\] "

# use vi bindings
set -o vi
