# Setup the prompt with pretty colors
setopt prompt_subst

RESET_COLOR="%f%b"

function ruby_version() { echo "%B%F{green}$(rbenv version-name)" }

# get the name of the branch we are on
function git_branch_name() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " %B%F{green}${ref#refs/heads/}$RESET_COLOR"
}

# Get the status of the working tree
function git_status() {
  STATUS=""
  if [[ -n $(git status -s 2> /dev/null) ]]; then
    STATUS="%B%F{yellow}✗$RESET_COLOR"
  fi
  INDEX=$(git status --porcelain 2> /dev/null)
  if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
    STATUS="$STATUS%B%F{blue} ?$RESET_COLOR"
  fi
  echo $STATUS
}

PROMPT='$(ruby_version) %B%F{cyan}%c$RESET_COLOR$(git_branch_name)$(git_status)%F{red} ➜ $RESET_COLOR'

# Right prompt for vi mode
function zle-line-init zle-keymap-select {
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

MODE_INDICATOR="%B%F{green}<<$RESET_COLOR"

function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
}

RPS1='$(vi_mode_prompt_info)'
