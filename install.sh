#!/bin/bash

DOTPATH=~/.dotfiles

# git が使えるなら git
if has "git"; then
	git clone --recursive "$GITHUB_URL" "$DOTPATH"

elif has "curl" || has "wget"; then
	tarball="https://github.com/b4b4r07/dotfiles/archive/master.tar.gz"

	if has "curl"; then
		curl -L "$tarball"

	elif has "wget"; then
		wget -O - "$tarball"

		fi | tar zxv

		mv -f dotfiles-master "$DOTPATH"

	else
		die "curl or wget required"
fi

cd ~/.dotfiles
if [ $? -ne 0 ]; then
	die "not found: $DOTPATH"
fi

# 移動できたらリンクを実行する
for f in .??*
do
	[ "$f" = ".git" ] && continue

	ln -snfv "$DOTPATH/$f" "$HOME/$f"
done
