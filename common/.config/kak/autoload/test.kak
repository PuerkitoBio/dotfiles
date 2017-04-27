# define the testcmd variable, to run on test
decl str testcmd

# define the test command, executes testcmd and prints the errors if any
def test %{ %sh{
  output=$(mktemp -d -t kak-test.XXXXXXXX)/fifo
  mkfifo ${output}
  ( eval ${kak_opt_testcmd} "$@" > ${output} 2>&1 ) > /dev/null 2>&1 < /dev/null &

  printf %s\\n "eval -try-client '$kak_opt_toolsclient' %{
    edit! -fifo ${output} -scroll *test*
    set buffer filetype make
    hook -group fifo buffer BufCloseFifo .* %{
      nop %sh{ rm -r $(dirname ${output}) }
      remove-hooks buffer fifo
    }
  }"
}}

