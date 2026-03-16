#!/bin/bash
set -euo pipefail

GITHUB_URL=https://github.com/arai-ryusuke/dotfiles
DOTPATH="$HOME/.dotfiles"

if [ -d "$DOTPATH/.git" ]; then
    echo "Updating dotfiles..."
    cd "$DOTPATH"
    git pull --rebase

elif type "git" > /dev/null 2>&1; then
    echo "Cloning dotfiles..."
    git clone --recursive "$GITHUB_URL" "$DOTPATH"

elif type "curl" > /dev/null 2>&1 || type "wget" > /dev/null 2>&1; then
    tarball="https://github.com/arai-ryusuke/dotfiles/archive/master.tar.gz"

    if type "curl" > /dev/null 2>&1; then
        curl -L "$tarball"
    elif type "wget" > /dev/null 2>&1; then
        wget -O - "$tarball"
    fi | tar zxv

    mv -f dotfiles-master "$DOTPATH"
else
    echo "git, curl, or wget required"
    exit 1
fi

cd "$DOTPATH" && make link
