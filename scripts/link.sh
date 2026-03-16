#!/bin/bash
set -euo pipefail

DOTPATH="$HOME/.dotfiles"

DOT_FILES=(.bash_profile .bashrc .gitconfig .tmux.conf .vimrc)
DOT_DIRS=(.vim)

safe_link() {
    local src="$1"
    local dst="$2"

    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        echo "skip: $dst (already linked)"
        return
    fi

    if [ -e "$dst" ] || [ -L "$dst" ]; then
        local backup="${dst}.backup.$(date +%Y%m%d%H%M%S)"
        echo "backup: $dst -> $backup"
        mv "$dst" "$backup"
    fi

    ln -snv "$src" "$dst"
}

# Link dot files
for f in "${DOT_FILES[@]}"; do
    safe_link "$DOTPATH/$f" "$HOME/$f"
done

# Link dot directories
for d in "${DOT_DIRS[@]}"; do
    safe_link "$DOTPATH/$d" "$HOME/$d"
done

# Link bin files
mkdir -p "$HOME/bin"
for f in "$DOTPATH"/bin/*; do
    [ -e "$f" ] || continue
    safe_link "$f" "$HOME/bin/$(basename "$f")"
done
