#!/bin/bash
set -euo pipefail

DOTPATH="$HOME/.dotfiles"

# packages/apt.txt からコメント・空行を除いたパッケージ一覧を取り出す
mapfile -t pkgs < <(sed -e 's/#.*//' -e 's/[[:space:]]*$//' "$DOTPATH/packages/apt.txt" | grep -v '^$')

echo "installing ${#pkgs[@]} packages..."
sudo apt update
# ACCEPT_EULA=Y は msodbcsql18 のライセンス同意用（他のパッケージには影響しない）
sudo ACCEPT_EULA=Y apt install -y "${pkgs[@]}"
