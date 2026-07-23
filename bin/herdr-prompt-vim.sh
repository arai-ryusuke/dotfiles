#!/usr/bin/env bash
# herdr のポップアップから呼ばれ、vim でプロンプトを作成して
# 背後のフォーカス中ペイン（claude等）の入力欄へ送る。
# 送信はせず入力欄に置くだけ（Enterはユーザーが押す）。
set -eu

herdr_bin="${HERDR_BIN_PATH:-herdr}"
target="${HERDR_ACTIVE_PANE_ID:-}"
if [ -z "$target" ]; then
  echo "HERDR_ACTIVE_PANE_ID がありません（herdrのpopupから起動してください）" >&2
  read -rn1 -p "何かキーを押すと閉じます"
  exit 1
fi

tmp="$(mktemp "${TMPDIR:-/tmp}/herdr-prompt-XXXXXX.md")"
trap 'rm -f "$tmp"' EXIT

vim "$tmp"

# 空のまま終了したら何も送らない
[ -s "$tmp" ] || exit 0

# $(cat) は末尾改行を落とすので、意図しないEnter送信にならない
"$herdr_bin" pane send-text "$target" "$(cat "$tmp")"
