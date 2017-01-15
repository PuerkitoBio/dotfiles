#!/bin/bash
############################
# This script creates symlinks from the home directory to any
# desired dotfiles.
#
# Adapted from
# http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/
############################

help=${1:-x}
if [[ ${help} == "-h" ]]; then
	echo "usage: ./install.sh [TARGETDIR] [BACKUPDIR]"
	exit 0
fi

os=`uname | tr '[:upper:]' '[:lower:]'`

srcdir=`pwd`/${os}
commondir=`pwd`/common
targetdir=${1:-$HOME}
olddir=${2:-`mktemp -d`}

# remove trailing slash for targetdir and olddir
targetdir=${targetdir%/}
olddir=${olddir%/}

if [[ ! -d ${srcdir} ]]; then
	echo "source directory ${srcdir} does not exist"
	exit 1
fi

# create olddir to backup existing files
mkdir -p ${olddir}
if [[ $? -ne 0 ]]; then
	echo "failed to create backup directory ${olddir}"
	exit 2
fi

echo "installing to ${targetdir} for OS ${os}"
echo

# backup existing files, and link new files in target dir
for filename in {${srcdir},${commondir}}/.*; do
  # consider only regular files (-f)
	if [[ -f ${filename} ]]; then
		filename=$(basename ${filename})

    # if file is symbolic link (-h) or standard file (exists, -e)
		if [[ -h ${targetdir}/${filename} || -e ${targetdir}/${filename} ]]; then
      # backup the existing file to the old directory
			mv ${targetdir}/${filename} ${olddir}/${filename}
		fi

    # create the symbolic link for the new file to put in place
		ln -s ${srcdir}/${filename} ${targetdir}/${filename}
		if [[ $? -ne 0 ]]; then
			echo "failed to symlink ${filename} to ${targetdir}"
			exit 3
		fi
		echo "${filename}"
	fi
done

echo
echo "existing files were backed up in ${olddir}"
echo

