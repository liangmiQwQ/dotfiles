#!/usr/bin/env sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
backup_dir="$HOME/.dotfiles-backup/$(date +%Y%m%d%H%M%S)"
backup_created=0

ensure_backup_dir() {
  if [ "$backup_created" -eq 0 ]; then
    mkdir -p "$backup_dir"
    backup_created=1
  fi
}

backup_existing() {
  dst=$1
  rel=${dst#"$HOME"/}
  backup_path="$backup_dir/$rel"

  ensure_backup_dir
  mkdir -p "$(dirname -- "$backup_path")"
  mv "$dst" "$backup_path"
  printf 'backup %s -> %s\n' "$dst" "$backup_path"
}

link_file() {
  src="$repo_dir/$1"
  dst=$2

  if [ ! -e "$src" ]; then
    printf 'missing %s\n' "$src" >&2
    return 1
  fi

  mkdir -p "$(dirname -- "$dst")"

  if [ -L "$dst" ]; then
    current=$(readlink "$dst")
    if [ "$current" = "$src" ]; then
      printf 'linked %s\n' "$dst"
      return 0
    fi
    backup_existing "$dst"
  elif [ -e "$dst" ]; then
    backup_existing "$dst"
  fi

  ln -s "$src" "$dst"
  printf 'link %s -> %s\n' "$dst" "$src"
}

link_file "zsh/zshrc" "$HOME/.zshrc"
link_file "zsh/zimrc" "$HOME/.zimrc"
link_file "git/gitconfig" "$HOME/.gitconfig"
link_file "git/gitignore" "$HOME/.gitignore"
link_file "config/git/ignore" "$HOME/.config/git/ignore"
link_file "gh/config.yml" "$HOME/.config/gh/config.yml"
link_file "mo/morc.json" "$HOME/.config/morc.json"
link_file "ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
link_file "kitty/base16_solarized_dark.color.conf" "$HOME/.config/kitty/base16_solarized_dark.color.conf"
link_file "kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
link_file "kitty/nightfox.color.conf" "$HOME/.config/kitty/nightfox.color.conf"
link_file "kitty/obsidian.color.conf" "$HOME/.config/kitty/obsidian.color.conf"
link_file "vscodium/settings.json" "$HOME/Library/Application Support/VSCodium/User/settings.json"
link_file "vscodium/keybindings.json" "$HOME/Library/Application Support/VSCodium/User/keybindings.json"

if [ "$backup_created" -eq 1 ]; then
  printf 'backups stored in %s\n' "$backup_dir"
fi
