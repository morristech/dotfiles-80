# Load all my files
for config_file ($HOME/.zsh/*.zsh) source $config_file

## Command history configuration
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt inc_append_history
setopt share_history # share command history data

# Changing/making/removing directory
setopt auto_pushd
setopt pushd_ignore_dups

# private configs
if [ -f $HOME/Dropbox/zshrc ]; then
  source $HOME/Dropbox/zshrc
fi

export CDPATH=:$HOME/code

# LS colors
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Of course
export EDITOR=vim

export PATH=.:./bin:$HOME/bin:/usr/local/bin:/usr/local/share/npm/bin:$PATH

# Use a menu for multiple options
zstyle ':completion:*:*:*:*:*' menu select

fpath=(~/.rvm/scripts/zsh/Completion $fpath)

# Load the completion system
autoload -U compinit
compinit

compdef hub=git
