#!/bin/sh

GITHUB_URL=https://github.com/arai-ryusuke/dotfiles
DOTPATH=~/.dotfiles

# git が使えるなら git
if type "git" > /dev/null 2>&1; then
	git clone --recursive "$GITHUB_URL" "$DOTPATH" 

elif type "curl" > /dev/null 2>&1|| type "wget" > /dev/null 2>&1; then
	tarball="https://github.com/arai-ryusuke/dotfiles/archive/master.tar.gz"

	if type "curl" > /dev/null 2>&1; then
		curl -L "$tarball"

	elif type "wget" > /dev/null 2>&1; then
		wget -O - "$tarball"

		fi | tar zxv

		mv -f dotfiles-master "$DOTPATH"

	else
		echo "curl or wget required"
		exit 1
fi

cd ~/.dotfiles
if [ $? -ne 0 ]; then
	echo "not found: $DOTPATH"
	exit 1
fi

# 移動できたらリンクを実行する
for f in .??*
do
	[ "$f" = ".git" ] && continue

	ln -snfv "$DOTPATH/$f" "$HOME/$f"
done

if [ ! -d bin ]; then
	mkdir bin
fi

cd bin
for f in *
do
	ln -snfv "$DOTPATH/bin/$f" "$HOME/bin/$f"
done
