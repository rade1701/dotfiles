#!/usr/bin/env bash
set -e
DOTFILES="$HOME/.dotfiles"
REPO="https://github.com/rade1701/dotfiles"
[ ! -d "$DOTFILES" ] && git clone "$REPO" "$DOTFILES"
bash "$DOTFILES/setup/ubuntu-wsl.sh"
