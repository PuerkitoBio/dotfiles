# implement directory listing
def -hidden -params 0 list_directory %{
  # list directory in a scratch buffer named "*dir*"
  edit -scratch *dir*
  # make buffer read-only
  set buffer readonly true
  # list the content of the current directory
  exec "!ls -A<ret>"
  # move selection to top of file
  exec gk
}

# goto selected file or list selected directory
def -hidden -params 0 goto_file_or_directory %{
  try %{
    # trying opening selected filename
    exec gf
  } catch %{
    # if it doesn't work, must be a directory, cd to it
    eval cd %val{selection}
    eval list_directory
  }
}

# make the <ret> key goto the selected file, '-' cd to parent directory
hook global BufCreate \*dir\* %{
  # map <ret> to open the selected file or cd to the selected directory
  map buffer normal <ret> '<space>xH:goto_file_or_directory<ret>'
  # map - to cd to the parent directory and list its contents
  map buffer normal -- -  ':cd ..<ret>; :list_directory<ret>'
}
# map ,e to list the directory contents
map global -docstring 'list files and directories' user e :list_directory<ret>

