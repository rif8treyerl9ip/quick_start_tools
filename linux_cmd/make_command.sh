#!/bin/sh

show_help() {
    cat << 'EOD'
This script sets up a specified source file as a Quick Start tool.

Summary:
- Copies the source file to $HOME/.local/bin/quick_start directory
- Grants execute permission to the copied file
- Adds PATH setting to .zshrc if necessary
- Updates the PATH for the current shell session

Usage:
  ./make_command.sh <source_file_path>

Examples:
  ./linux_cmd/make_command.sh linux_cmd/example/qs-alpine
  ./linux_cmd/make_command.sh linux_cmd/repository1/ex1
  ./linux_cmd/make_command.sh linux_cmd/repository1/feature1/ex2

Note:
- The source file path must contain "linux_cmd/"
- An error will occur if the source file does not exist
EOD
}

# ヘルプオプションのチェックを最初に行う
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_help
    exit 0
fi


QUICK_START_DIR="$HOME/.local/bin/quick_start"
SOURCE_PATH="${1:?Source file path is required}"  # 第1引数: ソースファイルパス（必須）
SHELL_CONFIG="$HOME/.zshrc"  # デフォルトで zsh を使用

RELATIVE_PATH=$(echo "$SOURCE_PATH" | sed -n 's/.*linux_cmd\/\(.*\)/\1/p')
if [ -z "$RELATIVE_PATH" ]; then
    echo "Error: The source path does not contain 'linux_cmd/'"
    exit 1
fi
if [ ! -f "$SOURCE_PATH" ]; then
    echo "Error: Source file '$SOURCE_PATH' does not exist."
    exit 1
fi

DIR_PATH="$QUICK_START_DIR/$(dirname "$RELATIVE_PATH")"
mkdir -p "$DIR_PATH"

FULL_PATH="$QUICK_START_DIR/$RELATIVE_PATH"
cp "$SOURCE_PATH" "$FULL_PATH"
chmod +x "$FULL_PATH"

# PATHにディレクトリを追加（設定ファイルに追記、まだ追加されていない場合）
if ! grep -q "export PATH=\"$DIR_PATH:\$PATH\"" "$SHELL_CONFIG"; then
    echo "export PATH=\"$DIR_PATH:\$PATH\"" >> "$SHELL_CONFIG"
fi

# 現在のシェルセッションのPATHを更新
export PATH="$DIR_PATH:$PATH"

echo "QUICK_START_DIR: $QUICK_START_DIR"
echo "SOURCE_PATH: $SOURCE_PATH"
echo "RELATIVE_PATH: $RELATIVE_PATH"
echo "SHELL_CONFIG: $SHELL_CONFIG"
echo "DIR_PATH: $DIR_PATH"
echo "FULL_PATH: $FULL_PATH"
# echo "PATH: $PATH"

echo "You can now use the '$(basename "$FULL_PATH")' command."
echo "Please restart your terminal or run 'source $SHELL_CONFIG' to ensure the changes take effect."
