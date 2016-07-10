alias ll='ls -la'
alias vim=nvim

# start databases
alias es='elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml'
alias pg='postgres -D /usr/local/var/postgres'
alias msql='mysql.server start'
alias redis='redis-server /usr/local/etc/redis.conf'
alias mongodb='mongod --config /usr/local/etc/mongod.conf'

# stop databases
alias kredis='pkill -TERM redis-server'
alias kpg='pkill -TERM postgres'
alias kmsql='mysql.server stop'
alias kes='kill -TERM $(pgrep -f elasticsearch)'
alias kmongodb='pkill mongod'

# auto-cd to last directory with just "-"
# see http://askubuntu.com/questions/146031/bash-alias-alias-name-should-be-a-simple-dash-not-working
alias -- -='cd -'

# run npm scripts without the noisy npm logs on non-zero exit codes
alias npmrun='npm run --silent $@'

# switch account for app engine
function appEngineSwitchAccount() {
    if [[ ! -f "${HOME}/.appcfg_oauth2_tokens.$1" ]]; then
        echo "no such app engine account"
        return 1
    fi

    cp "${HOME}/.appcfg_oauth2_tokens.$1" "${HOME}/.appcfg_oauth2_tokens"
}
alias aeuse='appEngineSwitchAccount $1'

# list external dependencies of a Go package
# usage: goextdep P, goextdep ./..., etc.
function listGoExternalDeps() {
    go list -f "{{.Deps}}" $1 | tr "[" " " | tr "]" " " | xargs go list -f "{{if not .Standard}}{{.ImportPath}}{{end}}"  | sort
}
alias goextdep='listGoExternalDeps'

