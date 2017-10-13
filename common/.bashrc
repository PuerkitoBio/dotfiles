### add ~/bin to PATH
if [[ :${PATH}: != *:"${HOME}/bin":* ]] ; then
  PATH=${PATH}:${HOME}/bin
fi

### define environment variables
export CLICOLOR=1
export EDITOR=vim
export OS_SHORT_NAME=$(uname | tr '[:upper:]' '[:lower:]')
if [[ ${OS_SHORT_NAME} == "darwin" ]]; then
  export MAKEFLAGS="-j$(sysctl -n hw.ncpu)"
else
  export MAKEFLAGS="-j$(nproc)"
fi
export SRCPATH=${HOME}/src

### quickly cd to common repo paths
CDPATH=.:${SRCPATH}/github.com:${SRCPATH}/bitbucket.org:${SRCPATH}/golang.org/x:${SRCPATH}/gitlab.com

### add OS-specific patches if any
if [[ -f "${HOME}/.bashrc_patch" ]]; then
  source "${HOME}/.bashrc_patch"
fi

### language/tools-specific setup, to be done before setting
### up aliases which may rely on them.

declare go_path=$(command -v go)
if [[ -e "${go_path}" && -x "${go_path}" ]]; then
  export GOPATH=${HOME}
fi

declare n_path=$(command -v n)
if [[ -e "${n_path}" && -x "${n_path}" ]]; then
  export N_PREFIX=${HOME}
fi

### load aliases if any
if [[ -f "${HOME}/.bash_aliases" ]]; then
  source "${HOME}/.bash_aliases"
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

### enable ctrl-s to search history forward (ctrl-r for reverse)
### https://www.blockloop.io/mastering-bash-and-terminal
stty -ixon

### automatic cd to directories, with spell correction
shopt -s autocd
shopt -s dirspell
shopt -s cdspell
shopt -s cdable_vars

### enable git-aware-prompt
### https://github.com/jimeh/git-aware-prompt
### must be after history config, sets PROMPT_COMMAND
export GITAWAREPROMPT=${HOME}/src/github.com/jimeh/git-aware-prompt
if [[ -f "${GITAWAREPROMPT}/main.sh" ]]; then
  source "${GITAWAREPROMPT}/main.sh"
fi

### customize prompt
PROMPT_DIRTRIM=3
PS1=" [\j] \u@\h \[$txtpur\]\w\[$txtrst\] \[$bakwht\]\[$txtblk\]\$git_branch\$git_dirty\[$txtrst\] \\$\[$(tput sgr0)\] "

### enable direnv
### https://github.com/direnv/direnv
### must be after history and prompt-manipulation config.
declare direnv_path=$(command -v direnv)
if [[ -e "${direnv_path}" && -x "${direnv_path}" ]]; then
  eval "$(direnv hook bash)"
fi

### load any out-of-repo extra source files that may be needed
for file in .bash_extra_*; do
  if [[ -f ${file} ]]; then
    source "${file}"
  fi
done

