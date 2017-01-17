# list entries in long format
if [[ "${OS_SHORT_NAME}" == "darwin" ]]; then
  # ls understands CLICOLOR, which is set
  alias ll='ls -la'
else
  alias ll='ls -la --color'
fi

# auto-cd to last directory with just "-"
# see http://askubuntu.com/questions/146031/bash-alias-alias-name-should-be-a-simple-dash-not-working
alias -- -='cd -'

# TODO : config paths may not be the same on various OS.

declare elasticsearch_path=$(command -v elasticsearch)
if [[ -e "${elasticsearch_path}" && -x "${elasticsearch_path}" ]]; then
	alias es='elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml'
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

declare go_path=$(command -v go)
if [[ -e "${go_path}" && -x "${go_path}" ]]; then
	# list external dependencies of a Go package
	# usage: goextdep P, goextdep ./..., etc.
	function listGoExternalDeps() {
	    go list -f "{{.Deps}}" $1 | tr "[" " " | tr "]" " " | xargs go list -f "{{if not .Standard}}{{.ImportPath}}{{end}}"  | sort
	}
	alias goextdep='listGoExternalDeps'
fi
