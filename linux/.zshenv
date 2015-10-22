# Set environment variables, even if not interactive shell
export EDITOR=vim
export PAGER=less
export CLICOLOR=1
export MAKEFLAGS='-j 4'
export GOPATH=$HOME
export OOC_LIBS=$HOME/src/ooc_libs
export NITPATH=$HOME/src/github.com/privat/nit
export RUBYGEMS_PATH=$HOME/.gem/ruby/2.2.0
export PATH=$PATH:$GOPATH/bin:$NITPATH/bin:$OOC_LIBS/rock/bin:$OOC_LIBS/sam:$RUBYGEMS_PATH/bin
export GOBIN=$GOPATH/bin
export TZ=America/New_York
export CC=gcc
export CXX=g++

CDPATH=.:$GOPATH/src/code.google.com/p:$GOPATH/src/github.com:$GOPATH/src/bitbucket.org:$GOPATH/src/golang.org/x
