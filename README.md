# quick_start_tools

開発環境のセットアップと作業効率化のためのツール集です。

## クイックスタート

### .devcontainerと.vscode設定の取得

```sh
git clone --filter=blob:none --no-checkout https://github.com/rif8treyerl9ip/quick_start_tools.git
cd quick_start_tools
git sparse-checkout init --no-cone
git sparse-checkout set .devcontainer .vscode
git checkout
mv .devcontainer ../
mv .vscode ../
cd .. && rm -rf quick_start_tools
```


## ディレクトリ構造

- **`conf/`** - 各種設定ファイル
  - `general/` - 汎用設定（Git設定、シェルエイリアス）
  - `formatter_linter/` - フォーマッター・リンター設定
- **`formatter_linter/`** - コードフォーマッター・リンター関連
  - `C/` - C言語用clang-format設定
  - `python/` - Python用フォーマット設定（ruff）
- **`git/`** - Git関連ユーティリティ
  - リポジトリ分割スクリプト
  - GitHub URL更新スクリプト
- **`vscode/`** - VSCode設定
  - `settings/` - 設定ファイルと拡張機能リスト
  - `snippets/` - コードスニペット（Python、Shell）
- **`work_efficiency/`** - 作業効率化ツール
- **`linux_cmd/`** - 非推奨（deprecated）
