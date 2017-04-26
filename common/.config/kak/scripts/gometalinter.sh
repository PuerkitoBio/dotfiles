#!/bin/bash

file=$1
dir=dirname ${file}
gometalinter --config=${HOME}/.config/gometalinter/config.json ${dir}

