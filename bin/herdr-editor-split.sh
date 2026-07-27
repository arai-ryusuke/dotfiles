#!/usr/bin/env bash
# claude の $VISUAL として呼ばれ（settings.json の env.VISUAL）、ctrl+g の
# 外部エディタをペイン内 vim ではなく herdr の右分割ペインの vim で開く。
# vim の終了（またはペインの消滅）まで待ってから戻ることで、claude 側は
# 通常の外部エディタ終了として編集結果を入力欄に読み戻す。
#
# herdr の外や必要コマンド欠如時は素の vim にフォールバックする。
set -eu

file="${1:?usage: herdr-editor-split.sh <file>}"

if [ "${HERDR_ENV:-}" != "1" ] || [ -z "${HERDR_PANE_ID:-}" ] \
  || ! command -v herdr >/dev/null 2>&1 || ! command -v jq >/dev/null 2>&1; then
  exec vim "$file"
fi

out="$(herdr pane split "$HERDR_PANE_ID" --direction right --ratio 0.5 --focus 2>/dev/null || true)"
new_id="$(printf '%s' "$out" | jq -r '.result.pane.pane_id // empty' 2>/dev/null || true)"
if [ -z "$new_id" ]; then
  exec vim "$file"
fi

fifo="$(mktemp -u "${TMPDIR:-/tmp}/herdr-editor-XXXXXX.fifo")"
mkfifo "$fifo"
watcher_pid=""
cleanup() {
  [ -n "$watcher_pid" ] && kill "$watcher_pid" 2>/dev/null || true
  rm -f "$fifo"
}
trap cleanup EXIT

# 分割ペインのシェルで vim を起動し、終了したら fifo に合図してペインも閉じる
herdr pane send-text "$new_id" \
  "clear; vim $(printf '%q' "$file"); printf done > $(printf '%q' "$fifo"); exit"
herdr pane send-keys "$new_id" enter

# vim ペインが手動で閉じられた等、合図なしに消えた場合のハング防止
(
  while herdr pane get "$new_id" >/dev/null 2>&1; do sleep 1; done
  printf gone > "$fifo" 2>/dev/null || true
) &
watcher_pid=$!

echo "→ 右ペイン($new_id)の vim で編集中…（保存終了でここに戻ります）"
read -r _ < "$fifo" || true
exit 0
