hook global WinSetOption filetype=go %{
  # enable reporting lint errors in the gutter
  lint-enable
  # use gometalinter as lint command (proxied by a script, because
  # gometalinter takes a directory as parameter, not a filename)
  set window lintcmd '${HOME}/.config/kak/scripts/gometalinter.sh'
  # run goimports on save
	hook window BufWritePost .*\.go 'go-format -use-goimports'
}

