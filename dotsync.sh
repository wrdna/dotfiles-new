#!/bin/bash

set -e  # Exit on error

# === CONFIG ===
DOTFILES_REPO="$HOME/dotfiles"
DOTFILES_SUBDIR="$DOTFILES_REPO/dotfiles"

# === USAGE CHECK ===
if [ $# -ne 1 ]; then
  echo "Usage: $0 [save|install]"
  exit 1
fi

MODE="$1"
if [[ "$MODE" != "save" && "$MODE" != "install" ]]; then
  echo "Invalid mode: $MODE. Use 'save' or 'install'."
  exit 1
fi

# === PATHS TO SYNC ===
declare -A SYNC_PATHS=(
  ["$HOME/.config/nvim"]="$DOTFILES_SUBDIR/nvim"
  ["$HOME/.config/zed"]="$DOTFILES_SUBDIR/zed"
  ["$HOME/.config/kitty"]="$DOTFILES_SUBDIR/kitty"
  ["$HOME/.vim"]="$DOTFILES_SUBDIR/.vim"
  ["$HOME/.zshrc"]="$DOTFILES_SUBDIR/.zshrc"
  ["$HOME/.bashrc"]="$DOTFILES_SUBDIR/.bashrc"
  ["$HOME/.tmux.conf"]="$DOTFILES_SUBDIR/.tmux.conf"
)

# === EXCLUSIONS ===
EXCLUDE_DIRS=(
  ".git"
  "node_modules"
  "venv"
  "__pycache__"
  "undodir"
)

RSYNC_EXCLUDES=()
for excl in "${EXCLUDE_DIRS[@]}"; do
  RSYNC_EXCLUDES+=(--exclude="$excl")
done

echo "Running in '$MODE' mode..."

for src in "${!SYNC_PATHS[@]}"; do
  dest="${SYNC_PATHS[$src]}"
  
  if [ "$MODE" == "save" ]; then
    echo "Updating: $src -> $dest"
    if [ -d "$src" ]; then
      rsync -va --delete "${RSYNC_EXCLUDES[@]}" "$src/" "$dest/"
    elif [ -f "$src" ]; then
      mkdir -p "$(dirname "$dest")"
      cp -u "$src" "$dest"
    else
      echo "Warning: $src does not exist, skipping."
    fi

  elif [ "$MODE" == "install" ]; then
    echo "Installing: $dest -> $src"
    if [ -d "$dest" ]; then
      rsync -va --delete "${RSYNC_EXCLUDES[@]}" "$dest/" "$src/"
    elif [ -f "$dest" ]; then
      mkdir -p "$(dirname "$src")"
      cp -u "$dest" "$src"
    else
      echo "Warning: $dest does not exist, skipping."
    fi
  fi
done

echo -e "\n\033[32mSync complete.\033[0m"

# === OPTIONAL GIT COMMIT ===
if [ "$MODE" == "save" ]; then
  cd "$DOTFILES_REPO"
  if [ -n "$(git status --porcelain)" ]; then
    echo ""
    read -p "Commit changes? [y/N]: " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
      git add .
      read -p "Commit message: " msg
      git commit -m "$msg"
      echo "Committed changes."
    else
      echo "Skipped committing."
    fi
  else
    echo "No changes to commit."
  fi
fi
