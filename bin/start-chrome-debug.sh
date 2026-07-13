#!/usr/bin/env bash
# Chrome DevTools MCP 用: Windows側ChromeをデバッグポートON・専用プロファイルで起動する
# プロファイル置き場は実行時に Windows の %USERPROFILE% から導出する（個人情報のハードコードなし）
# 変更したい場合は環境変数で上書き:
#   CHROME_MCP_PROFILE_DIR : プロファイルのWindowsパス（既定: %USERPROFILE%\chrome-mcp-profile）
#   CHROME_MCP_PORT        : デバッグポート（既定: 9222）
# 注意: このChromeウィンドウはAI(MCP)から完全制御可能。必要なサイトにだけログインし、
#       使い終わったらウィンドウを閉じること（閉じればデバッグポートも閉じる）。
set -eu

CHROME_EXE="/mnt/c/Program Files/Google/Chrome/Application/chrome.exe"
PORT="${CHROME_MCP_PORT:-9222}"

if [ -z "${CHROME_MCP_PROFILE_DIR:-}" ]; then
  WIN_HOME="$(/mnt/c/Windows/System32/cmd.exe /c 'echo %USERPROFILE%' 2>/dev/null | tr -d '\r\n')"
  if [ -z "$WIN_HOME" ]; then
    echo "エラー: Windowsのユーザープロファイルを取得できませんでした" >&2
    exit 1
  fi
  CHROME_MCP_PROFILE_DIR="${WIN_HOME}\\chrome-mcp-profile"
fi

"$CHROME_EXE" \
  --remote-debugging-port="$PORT" \
  --user-data-dir="$CHROME_MCP_PROFILE_DIR" \
  --no-first-run \
  >/dev/null 2>&1 &
echo "デバッグ用Chromeを起動しました（プロファイル: $CHROME_MCP_PROFILE_DIR / ポート: $PORT）"
echo "確認: curl -s http://127.0.0.1:${PORT}/json/version"
