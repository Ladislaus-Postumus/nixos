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
bind '"\t": menu-complete'            # use menu instead of spilling completion to stdout
bind '"\e[Z": menu-complete-backward' # use shift-tab to cycle menu backward
bind 'set completion-ignore-case on'
bind 'set history-preserve-point on'

eval "$(starship init bash)"

alias ls='eza --icons=always -1 --hyperlink --colour=always'
alias ll='eza --icons=always -1 --hyperlink --colour=always --tree -lgh'
#alias echo='cowsay -f stegosaurus'
alias nos='nh os switch'
alias not='nh os test'

eval "$(zoxide init --cmd cd bash)"
eval "$(direnv hook bash)"

if [ -z $TMUX ]; then
  fastfetch
  printf "\n"
  awk '/^# /{h1=$0; sub(/^#+ +/, "", h1)} /^## /{h2=$0; sub(/^##+ +/, "", h2)} /^>/{sub(/^>+ +/, ""); quote=quote $0 "\n"; next} /^—/{if(quote){sub(/^— +/, ""); printf "\033[3m%s—%s %s %s\033[0m\0", quote, h1, h2, $0; quote=""}}' ~/notes/quotes.norg | shuf -n 1 -z
fi
