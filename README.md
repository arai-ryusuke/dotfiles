# dotfiles

## Install

```
bash -c "$(curl -L raw.githubusercontent.com/arai-ryusuke/dotfiles/master/install.sh)"
```

## Manual link

```
make link
```

## New machine setup (WSL2 / Ubuntu)

```
make setup   # apt-repos.sh → apt-install.sh → link.sh
```

- `packages/apt.txt` — 導入するAPTパッケージ一覧（コメントで用途を記載）
- `scripts/apt-repos.sh` — サードパーティAPTリポジトリ登録（docker / github-cli / mssql / azure-cli）
- `scripts/apt-install.sh` — apt.txt を読んで一括インストール

### git管理外の手動移行リスト

- `~/.claude/` — Claude Code 設定（認証情報を含むためgit管理外。旧端末からコピー）
- `~/.ssh/` — SSH鍵
- 言語バージョン管理 — anyenv(nodenv) / pyenv / rbenv を各公式手順で導入
- herdr — https://herdr.dev の手順でインストール
- Windows Terminal 設定（Windows側）

## Files

- `.bash_profile`
- `.bashrc`
- `.gitconfig`
- `.tmux.conf`
- `.vimrc`
- `.vim/`
- `.asoundrc` — WSL2でALSAをPulseAudio(WSLg)に向ける（通知音再生用。apt.txtの音声系パッケージとセット）
- `.config/herdr/config.toml` — herdr 設定
- `bin/`
