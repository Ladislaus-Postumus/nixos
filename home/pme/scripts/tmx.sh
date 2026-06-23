#!/usr/bin/env bash

if [ -n "$1" ]; then
  TARGET_DIR=$(zoxide query "$1")
  if [ -z "$TARGET_DIR" ]; then
    echo "Error: Zoxide could not find a project matching '$1'"
    exit 1
  fi
else
  TARGET_DIR=$(pwd)
fi

SESSION_NAME=$(basename "$TARGET_DIR" | tr '.' '_')

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  tmux attach-session -t "$SESSION_NAME"
  exit 0
fi

tmux new-session -d -s "$SESSION_NAME" -c "$TARGET_DIR" -n "editor"
tmux send-keys -t "$SESSION_NAME:1" "nvim ." C-m
tmux split-window -h -c "$TARGET_DIR" -t "$SESSION_NAME:1"
tmux resize-pane -t "$SESSION_NAME:1.1" -x "80%"

if [ -f "$TARGET_DIR/Cargo.toml" ]; then
  tmux send-keys -t "$SESSION_NAME:1.1" "cargo watch -x run" C-m
elif [ -d "$TARGET_DIR/.git" ]; then
  tmux send-keys -t "$SESSION_NAME:1.1" "git status" C-m
fi

tmux select-pane -t "$SESSION_NAME:1.0"

tmux attach-session -t "$SESSION_NAME"
