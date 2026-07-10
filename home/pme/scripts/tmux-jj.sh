#!/usr/bin/env bash

ORIGINAL_PANE=$(tmux display-message -p '#{pane_id}')
# 1. Look for a pane in the current window explicitly titled 'jj-watcher'
# '|| true' stops 'set -e' from crashing the script if grep finds nothing
TARGET_PANE=$(tmux list-panes -F '#{pane_id} #{pane_title}' | grep 'jj-watcher' | cut -d' ' -f1 || true)

if [ -n "$TARGET_PANE" ]; then
  # 2. If it exists, kill only that specific pane ID
  tmux kill-pane -t "$TARGET_PANE"
else
  # 3. If it doesn't, open it, set the title, and execute the watch loop
  tmux split-window -h -l 50 "tmux select-pane -T jj-watcher; find .jj -maxdepth 2 | entr -c jj log --no-pager -T 'change_id.shortest(5) ++ \" \" ++ if(self.empty(), label(\"warning\", \"󰆧 \"), \" \") ++ description.first_line() ++ \"\n\" '"
  tmux select-pane -t "$ORIGINAL_PANE"
fi
