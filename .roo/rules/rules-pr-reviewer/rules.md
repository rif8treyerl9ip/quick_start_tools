# GitHub プルリクエストレビュールール

## 概要
現在チェックアウトされているブランチのプルリクエスト（PR）の内容と差分を自動的に取得し、包括的なレビューを実行するワークフローです。

## 使用方法

### 基本的なレビューコマンド
以下のプロンプトを使用して、完全なPRレビューを実行できます：

```
このブランチで作成されたプルリクエストの内容と差分をレビューし、変更点を要約してください。
また、詳細なレビューが必要な箇所があれば提案してください。
得られた情報に基づいて、PRの目的、主な変更点、影響範囲を日本語で要約してください。
```

### 内部処理
レビュー実行時に、以下のコマンドが自動的に実行されます：

```bash
git branch --show-current
```

```bash
pr_count=$(gh pr list --json number --jq length)

if [ "$pr_count" -eq 0 ]; then
   gh pr create --title "<issue number>" --body "issues: <#<issue number>> or ''"
fi
```

```bash
mkdir .tmp_pr

# PRの詳細情報（タイトル、説明、レビュアー、ステータス等）を取得
gh pr view > .tmp_pr/PR_VIEW.log

# PRの差分を取得
gh pr diff > .tmp_pr/PR_DIFF.log
```

### レビュー完了後の操作
レビューが完了し、マージの準備ができたら、「finish」 と入力することで以下の処理が自動実行されます：

```bash
gh pr merge --merge
rm -rf .tmp_pr
git push origin --delete <branch name>
gh issue close <issue number>
git checkout main
git pull
```
