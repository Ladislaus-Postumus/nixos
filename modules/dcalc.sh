# dcalc — dmenu calculator with history
# Enter: evaluate | Tab: pull a history entry into the input to edit | Esc: quit (last result -> clipboard)

definitions='scale=2' # variable definitions go here, separated by newline

hist="${XDG_DATA_HOME:-$HOME/.local/share}/dcalc_history"
mkdir -p "${hist%/*}"
touch "$hist"
export BC_LINE_LENGTH=0
ans=0
prompt="calc:"

while true; do
  # newest first, deduplicated
  input=$(tac "$hist" | awk '!seen[$0]++' | dmenu -l 10 -p "$prompt") || break
  [ -z "$input" ] && break
  expr=${input%% = *} # picking "2*3 = 6" reuses "2*3"

  # handle ans natively
  case $expr in
  [+*/^%]*) expr="($ans)$expr" ;;
  esac

  res=$(printf '%sans=%s\n%s\n' "$definitions" "$ans" "$expr" | bc -l 2>/dev/null | tail -n1)
  if [ -z "$res" ]; then
    prompt="error:"
    continue
  fi
  case $res in *.*) # strip trailing zeros, fix ".5" -> "0.5"
    res=$(printf %s "$res" | sed 's/0*$//; s/\.$//; s/^\./0./; s/^-\./-0./')
    ;;
  esac

  ans=$res
  printf '%s = %s\n' "$expr" "$res" >>"$hist"
  prompt="= $res"
done

[ "$ans" != 0 ] && printf %s "$ans" | xclip -selection clipboard
