#!/bin/bash

# gometalinter works with a directory, and reports errors in all files.
# This script runs in the context of the working directory of the editor,
# so pass this directory to gometalinter and grep only the issues that
# relate to the current file.

# BUG: this means that it doesn't work on unsaved buffer.

currentDir=$(pwd)
currentFile=${kak_buffile}

gometalinter --config=${HOME}/.config/gometalinter/config_quick.json ${currentDir} | grep -e "^${currentFile}:"

