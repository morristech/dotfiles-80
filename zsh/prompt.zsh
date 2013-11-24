setopt prompt_subst

RESET_COLOR="%f%b"

__where() {
        echo "%B%F{yellow}%n%B%F{white}@%F{blue}%m$RESET_COLOR"
}

__ruby() { echo "%B%F{yellow}$(chruby | grep '*' | tr -d '* ' | sed 's/ruby-//')" }

__branch() {
        ref=$(git symbolic-ref --short HEAD 2> /dev/null)
        if [ -z "$ref" ]; then
                ref=$(git reflog 2> /dev/null | grep checkout | head -n1 | awk '{print $NF}')
        fi
        if [ -z "$ref" ]; then
                return
        fi
        echo " %B%F{green}$ref$RESET_COLOR"
}

__status() {
        STATUS=""
        if [[ -n $(git status -s 2> /dev/null) ]]; then
                STATUS="%F{yellow}✗$RESET_COLOR"
        fi
        INDEX=$(git status --porcelain 2> /dev/null)
        if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
                STATUS="$STATUS%F{blue} ?$RESET_COLOR"
        fi
        echo $STATUS
}

PROMPT='$(__ruby) %B%F{cyan}%c$RESET_COLOR$(__branch)$(__status)%F{red} ➜ $RESET_COLOR'
RPROMPT='$(__where)'
