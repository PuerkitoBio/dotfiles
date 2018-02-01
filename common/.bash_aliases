# list entries in long format
if [[ "${OS_SHORT_NAME}" == "darwin" ]]; then
  # ls understands CLICOLOR, which is set
  alias ll='ls -la'
else
  alias ll='ls -la --color'
fi

# find files and directories
function __findFiles() {
  local name=$1; shift;
  find ${*:-.} -type f -name "${name}" 2>&1 | grep -v -e ": Permission denied$"
}
function __findDirs() {
  local name=$1; shift;
  find ${*:-.} -type d -name "${name}" 2>&1 | grep -v -e ": Permission denied$"
}
alias findf='__findFiles'
alias findd='__findDirs'
alias findbig='du -kh | egrep "^\d+(\.\d+)?G"'

# auto-cd to last directory with just "-"
# see http://askubuntu.com/questions/146031/bash-alias-alias-name-should-be-a-simple-dash-not-working
alias -- -='cd -'

# TODO : config paths may not be the same on various OS.

declare elasticsearch_path=$(command -v elasticsearch)
if [[ -e "${elasticsearch_path}" && -x "${elasticsearch_path}" ]]; then
	alias es='elasticsearch'
	alias kes='kill -s TERM $(pgrep -f elasticsearch)'
fi

declare postgres_path=$(command -v postgres)
if [[ -e "${postgres_path}" && -x "${postgres_path}" ]]; then
	alias pg='postgres -D /usr/local/var/postgres'
	alias kpg='pkill -TERM postgres'
fi

declare mysql_path=$(command -v mysql.server)
if [[ -e "${mysql_path}" && -x "${mysql_path}" ]]; then
	alias msql='mysql.server start'
	alias kmsql='mysql.server stop'
fi

declare redis_path=$(command -v redis-server)
if [[ -e "${redis_path}" && -x "${redis_path}" ]]; then
	alias redis='redis-server /usr/local/etc/redis.conf'
	alias kredis='pkill -TERM redis-server'
fi

declare mongo_path=$(command -v mongod)
if [[ -e "${mongo_path}" && -x "${mongo_path}" ]]; then
	alias mongodb='mongod --config /usr/local/etc/mongod.conf'
	alias kmongodb='pkill mongod'
fi

declare npm_path=$(command -v npm)
if [[ -e "${npm_path}" && -x "${npm_path}" ]]; then
	# run npm scripts without the noisy npm logs on non-zero exit codes
	alias npmrun='npm run --silent'
fi

declare pacman_path=$(command -v pacman)
if [[ -e "${pacman_path}" && -x "${pacman_path}" ]]; then
	alias pacman--install='sudo pacman -S'
	alias pacman--install-local='sudo pacman -U'
  alias pacman--install-aur='makepkg -sic'
	alias pacman--remove='sudo pacman -R'
  alias pacman--remove-orphans='sudo pacman -R $(pacman -Qdtq)'
  alias pacman--list-installed='pacman -Qe'
  alias pacman--list-installed-deps='pacman -Qd'
  alias pacman--list-installed-local='pacman -Qem'
	alias pacman--upgrade='sudo pacman -Syu'
  alias pacman--download-aur='cower -dd'
  alias pacman--download-outdated-aur='cower -ud'
	alias pacman--outdated='pacman -Qu'
	alias pacman--outdated-aur='cower -u'
	alias pacman--search='pacman -Ss'
	alias pacman--search-local='pacman -Qs'
  alias pacman--search-aur='cower -s'
	alias pacman--info='pacman -Si'
	alias pacman--orphans='pacman -Qdt'
	alias pacman--deps-tree='pactree'
	alias pacman--depended-on-tree='pactree -r'
	alias pacman--cleanup='sudo pacman -Sc'
  alias pacman--file-owner='pacman -Qo'
fi

declare apt_path=$(command -v apt)
if [[ -e "${apt_path}" && -x "${apt_path}" ]]; then
  alias apt--install='sudo apt install'
  alias apt--remove='sudo apt remove'
  alias apt--list-installed='apt list'
  alias apt--upgrade='sudo apt update && sudo apt upgrade'
  alias apt--outdated='sudo apt update && apt list --upgradable'
  alias apt--search='apt search'
  alias apt--info='apt show'
  alias apt--cleanup='sudo apt autoremove'
fi

declare snap_path=$(command -v snap)
if [[ -e "${snap_path}" && -x "${snap_path}" ]]; then
  alias snap--install='sudo snap install'
  alias snap--remove='sudo snap remove'
  alias snap--list-installed='snap list'
  alias snap--upgrade='sudo snap refresh'
  alias snap--outdated='snap refresh --list'
  alias snap--search='snap find'
  alias snap--info='snap info'
fi

declare thefuck_path=$(command -v thefuck)
if [[ -e "${thefuck_path}" && -x "${thefuck_path}" ]]; then
  # thefuck automatically generates its alias with this eval
  eval $(thefuck --alias)
fi

declare go_path=$(command -v go)
if [[ -e "${go_path}" && -x "${go_path}" ]]; then
	# list external dependencies of a Go package
	# usage: goextdep P, goextdep ./..., etc.
	function __listGoExternalDeps() {
	    go list -f "{{.Deps}}" $1 | tr "[" " " | tr "]" " " | xargs go list -f "{{if not .Standard}}{{.ImportPath}}{{end}}"  | sort
	}
	alias goextdep='__listGoExternalDeps'
fi

declare ag_path=$(command -v ag)
if [[ -e "${ag_path}" && -x "${ag_path}" ]]; then
  alias ag--novend='ag --ignore-dir vendor/'
fi

declare xcode_path=$(command -v xcodebuild)
if [[ -e "${xcode_path}" && -x "${xcode_path}" ]]; then
  # run an executable built by Xcode
  function __runXcodeApp() {
    local conf=${2:-Debug}
    local proj="$1/$1.xcodeproj"
    if [[ ! -d ${proj} ]]; then
      proj="$1.xcodeproj"
      if [[ ! -d ${proj} ]]; then
        echo $1 not found: expected to find ${proj}
        return
      fi
    fi
    # echo "proj=${proj}"

    local base_dir=$(xcodebuild -showBuildSettings -project ${proj}  -configuration ${conf} 2>/dev/null | grep CONFIGURATION_BUILD_DIR | xargs | cut -d " " -f 3)
    local product=$(xcodebuild -showBuildSettings -project ${proj} -configuration ${conf} 2>/dev/null | grep FULL_PRODUCT_NAME | xargs | cut -d " " -f 3)
    local full_path=${base_dir}/${product}

    # echo "base_dir=${base_dir}, product=${product}, full_path=${full_path}"

    # exists and is executable
    if [[ -e "${full_path}" && -x "${full_path}" ]]; then
      if [[ "${full_path: -4}" == ".app" ]]; then
        open ${full_path}
      else
        ${full_path}
      fi
    else
      echo $1 not found: expected to find app build at ${full_path}
    fi
  }
  alias xcrunapp='__runXcodeApp'
fi

if [[ ${SRCPATH} ]]; then
  declare git_path=$(command -v git)
  if [[ -e "${git_path}" && -x "${git_path}" ]]; then
    function __cloneRepo() {
      local host=$(echo "$1" | cut -d/ -s -f 1)
      local author=$(echo "$1" | cut -d/ -s -f 2)
      local repo=$(echo "$1" | cut -d/ -s -f 3)
      if [[ ! ${host} || ! ${author} || ! ${repo} ]]; then
        echo "invalid repository: want host/author/repo"
        return
      fi

      mkdir -p "${SRCPATH}/${host}/${author}/${repo}"
      cd "${SRCPATH}/${host}/${author}"
      git clone "git@${host}:${author}/${repo}.git"
      cd "${SRCPATH}/${host}/${author}/${repo}"
    }
    alias gitclone='__cloneRepo'
  fi
fi

