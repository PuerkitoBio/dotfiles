### define environment variables
PATH=$PATH:$HOME/bin:$HOME/src/go/bin:$HOME/src/go_appengine
export GOPATH=$HOME
export N_PREFIX=$HOME
export CLICOLOR=1
export EDITOR=vim
export GITAWAREPROMPT=$GOPATH/src/github.com/jimeh/git-aware-prompt
CDPATH=.:$GOPATH/src/github.com:$GOPATH/src/bitbucket.org:$GOPATH/src/golang.org/x:$GOPATH/src/gitlab.com

### load aliases if any
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

### enable bash-completion (installed from brew, AFTER installing and
### upgrading to bash 4.x)
### http://blog.pivotal.io/labs/labs/cdpath-bash-completion-in-osx
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
fi

### configure history
### see http://mrzool.cc/writing/sensible-bash/
shopt -s histappend                          # append to the history file, don't overwrite it
shopt -s cmdhist                             # save multi-line commands as one command
PROMPT_COMMAND='history -a'                  # record each line as it gets issued
HISTSIZE=500000                              # huge history
HISTFILESIZE=100000
HISTCONTROL="erasedups:ignoreboth"           # avoid duplicate entries
HISTIGNORE="&:[ ]*:exit:ll:ls:bg:fg:history" # ignore some common commands
HISTTIMEFORMAT='%F %T'                       # useful timestamp format (doesn't work?)

### automatic cd to directories, with spell correction
shopt -s autocd
shopt -s dirspell
shopt -s cdspell
shopt -s cdable_vars

### enable git-aware-prompt
### https://github.com/jimeh/git-aware-prompt
### must be after history config, sets PROMPT_COMMAND
if [ -f $GITAWAREPROMPT/main.sh ]; then
    source $GITAWAREPROMPT/main.sh
fi
PROMPT_DIRTRIM=3
PS1="\u@\h \[$txtpur\]\w\[$txtrst\] \[$bakwht\]\[$txtblk\]\$git_branch\$git_dirty\[$txtrst\] \\$\[$(tput sgr0)\] "

### enable direnv
### https://github.com/direnv/direnv
### must be after history and prompt-manipulation config.
eval "$(direnv hook bash)"
