#!/bin/bash
# セッション終了時に会話ログを保存

if ! which jq > /dev/null 2>&1; then
  echo "Error: jq is required" >&2
  exit 1
fi

INPUT=$(cat)
TRANSCRIPT_PATH=$(echo "$INPUT" | jq -r '.transcript_path // empty')

if [ -z "$TRANSCRIPT_PATH" ] || [ ! -f "$TRANSCRIPT_PATH" ]; then
  exit 0
fi

# 保存先: .claude/.tanaoroshi/logs/pending/
TANAOROSHI_DIR="$(pwd)/.claude/.tanaoroshi"
PENDING_DIR="$TANAOROSHI_DIR/logs/pending"
mkdir -p "$PENDING_DIR"

# .gitignore を作成（まだなければ）
GITIGNORE="$TANAOROSHI_DIR/.gitignore"
if [ ! -f "$GITIGNORE" ]; then
  echo '*' > "$GITIGNORE"
  echo '!.gitignore' >> "$GITIGNORE"
fi

FILENAME="session-$(date +%Y-%m-%d-%H%M%S).jsonl"
cp "$TRANSCRIPT_PATH" "$PENDING_DIR/$FILENAME"

exit 0
