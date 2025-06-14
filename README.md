# quick_start_tools

開発環境のセットアップと作業効率化のためのツール集です。Roo Codeカスタムモード設定、コード品質管理、開発環境設定を含みます。

## 主要機能

- **Roo Codeカスタムモード**: PR レビューと技術文書作成専用モード
- **コード品質管理**: pre-commit フック、EditorConfig、フォーマッター設定
- **開発環境設定**: 各種言語対応の統一設定

## クイックスタート

### 1. 設定ファイルの取得

```bash
git clone --filter=blob:none --no-checkout https://github.com/rif8treyerl9ip/quick_start_tools.git
cd quick_start_tools
git sparse-checkout init --no-cone
git sparse-checkout set .devcontainer .vscode .editorconfig .pre-commit-config.yaml
git checkout
mv .devcontainer .vscode .editorconfig .pre-commit-config.yaml ../
```

## ファイル構成

### 設定ファイル

- **[`.roomodes`](.roomodes)** - Roo Code カスタムモード設定
  - `pr-reviewer`: GitHub PR レビュー専用モード
  - `docs`: AsciiDoc 技術文書作成モード
- **[`.editorconfig`](.editorconfig)** - エディタ統一設定
  - Python, C++, Shell, JavaScript 対応
  - Google スタイルガイド準拠
- **[`.pre-commit-config.yaml`](.pre-commit-config.yaml)** - コミット前品質チェック
  - ruff (Python フォーマッター・リンター)
  - shellcheck (Shell スクリプト解析)

### ユーティリティ

- **[`unused/`](unused/)** - 過去のツール・設定ファイル
  - `conf/`: Git 設定、シェルエイリアス
  - `formatter_linter/`: 言語別フォーマッター設定
  - `git/`: リポジトリ管理スクリプト