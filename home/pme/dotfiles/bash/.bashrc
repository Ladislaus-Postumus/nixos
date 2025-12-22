shopt -s histappend
PROMPT_COMMAND='history -a; history -n'
export HISTCONTROL=ignoreboth:erasedups

fzf-history-widget() {
    local selected
    selected=$(history | fzf +s --tac | sed 's/^[[:space:]]*[0-9]*[[:space:]]*//')
    if [[ -n "$selected" ]]; then
        READLINE_LINE="$selected"
        READLINE_POINT=${#READLINE_LINE}
    fi
}

bind -x '"\C-r": fzf-history-widget'
bind '"\t": menu-complete' # use menu instead of spilling completion to stdout
bind '"\e[Z": menu-complete-backward' # use shift-tab to cycle menu backward
bind 'set completion-ignore-case on'
bind 'set history-preserve-point on'

eval "$(starship init bash)"

alias ls='eza --icons=always -1 --hyperlink --colour=always'
alias echo='cowsay -f stegosaurus'
alias nos='nh os switch'
alias not='nh os test'
