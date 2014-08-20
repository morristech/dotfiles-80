# function to go to a parent directory of the current directory.
# It takes the number of directory to ascend as argument.
up() {
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
  do
    d=$d/..
  done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}

# List all my code dirs
projects() {
  ls -d ~/code/*/ ~/code/src/github.com/lucapette/*/
}

# Show git status with no args, delegate to git otherwise
g() {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status -s
  fi
}

loop() {
  while true; do $@ || break; done
}

w() {
  tmux new-window
  tmux send "$*" C-m
}

p() {
  tmux split
  tmux send "$*" C-m
}

docker() {
  if command -v "docker-$1" > /dev/null 2>&1; then
    subcommand=$1
    shift
    docker-$subcommand $@
  else
    /usr/local/bin/docker $@
  fi
}
