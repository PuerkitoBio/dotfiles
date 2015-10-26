alias ll='ls -la'

# start databases
alias es='elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml'
alias pg='postgres -D /usr/local/var/postgres'
alias mysql='mysql.server start'
alias redis='redis-server /usr/local/etc/redis.conf'

# stop databases
alias kredis='pkill -TERM redis-server'
alias kpg='pkill -TERM postgres'
alias kmysql='mysql.server stop'
alias kes='kill -TERM $(pgrep -f elasticsearch)'
