hook global WinSetOption filetype=go %{
  # enable reporting lint errors in the gutter
  lint-enable

  # use gometalinter as lint command (proxied by a script, because
  # gometalinter takes a directory as parameter, not a filename)
  set window lintcmd '${HOME}/.config/kak/scripts/gometalinter.sh'

	# use the full list of linters (including gotype) for the make command
	set window makecmd 'gometalinter --config=${HOME}/.config/gometalinter/config_full.json'

	# use gometalinter to run tests
	set window testcmd 'gometalinter --config=${HOME}/.config/gometalinter/config_test.json'

  # enable go auto-completion
  go-enable-autocomplete

	# goto definition
	map global normal <a-g> ':go-jump<ret>'

	# show godoc
	map global normal <a-d> ':go-doc-info<ret>'

  # run goimports on save
	hook window BufWritePost .*\.go %{
		# format and import required packages
  	go-format -use-goimports

  	# run lint
		lint
  }
}

