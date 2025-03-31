#!/bin/bash

set -e  # Exit on error

# === CONFIG ===
DOTFILES_REPO="$HOME/dotfiles"
DOTFILES_SUBDIR="$DOTFILES_REPO/dotfiles"

# === PATHS TO SYNC (LIVE -> REPO) ===
declare -A SYNC_PATHS=(
  # ~/.config/
  ["$HOME/.config/nvim"]="$DOTFILES_SUBDIR/nvim"
  ["$HOME/.config/zed"]="$DOTFILES_SUBDIR/zed"
  ["$HOME/.config/kitty"]="$DOTFILES_SUBDIR/kitty"

  # ~/
  ["$HOME/.vim"]="$DOTFILES_SUBDIR/.vim"
  ["$HOME/.zshrc"]="$DOTFILES_SUBDIR/.zshrc"
  ["$HOME/.bashrc"]="$DOTFILES_SUBDIR/.bashrc"
  ["$HOME/.tmux.conf"]="$DOTFILES_SUBDIR/.tmux.conf"
)

echo "Starting sync..."

# === EXCLUSIONS ===
EXCLUDE_DIRS=(
  ".git"
  "node_modules"
  "venv"
  "__pycache__"
  ".vim/undodir/"
)

# Convert to rsync exclude options
RSYNC_EXCLUDES=()
for excl in "${EXCLUDE_DIRS[@]}"; do
  RSYNC_EXCLUDES+=(--exclude="$excl")
done

for src in "${!SYNC_PATHS[@]}"; do
  dest="${SYNC_PATHS[$src]}"
  echo "Syncing: $src -> $dest"

  if [ -d "$src" ]; then
    rsync -va --delete "${RSYNC_EXCLUDES[@]}" "$src/" "$dest/"
  elif [ -f "$src" ]; then
    mkdir -p "$(dirname "$dest")"
    cp -u "$src" "$dest"
  else
    echo "Warning: $src does not exist, skipping."
  fi
done

printf "\n\e[32mSync complete.\e[0m"

# === OPTIONAL: Git commit ===
cd "$DOTFILES_REPO"
if [ -n "$(git status --porcelain)" ]; then

  # echo "Changes detected:"
  # git status -s
  
  echo ""
  # read -p "Commit changes? [y/N]: " confirm
  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    git add .
    read -p "Commit message: " msg
    git commit -m "$msg"
    printf "Committed changes."
  else
    printf "Skipped committing."
  fi
else
  printf "No changes to commit."
fi
