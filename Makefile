.PHONY: all link repos packages setup

all: link

link:
	@bash scripts/link.sh

repos:
	@bash scripts/apt-repos.sh

packages:
	@bash scripts/apt-install.sh

# 新しいマシンの初期構築（リポジトリ登録 → パッケージ導入 → symlink）
setup: repos packages link
