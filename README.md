# tanaoroshi - セッションログ棚卸しプラグイン

Claude Codeとのセッションログから価値ある発見（Findings）を抽出し、プロジェクト知識として蓄積するプラグイン。

## 特徴

- **自動保存**: セッション終了時にログを自動保存
- **棚卸し**: 「棚卸しして」と言うだけで発見を抽出・整理
- **カテゴリ管理**: ユーザー定義カテゴリ + 自動振り分け
- **Claude Codeとの連携**: 蓄積した知識を自動参照するルールを生成

## インストール
```bash
/plugin marketplace add chatii/claude-code-tanaoroshi
/plugin install tanaoroshi
```

## 使い方

### セッションログの自動保存

プラグインをインストールすると、セッション終了時に会話ログが自動保存される：
```
.claude/.tanaoroshi/logs/pending/session-YYYY-MM-DD-HHMMSS.jsonl
```

### 棚卸しの実行
```
棚卸しして
```

または
```
セッションログを整理して
発見をまとめて
```

### 出力先
```
.claude/
├── findings/                    # 発見の蓄積先
│   ├── index.md                 # 発見の一覧
│   ├── {category}/              # ユーザー定義カテゴリ
│   └── _etc/                    # 自動振り分けカテゴリ
│       └── {autoCategoryName}/
├── rules/
│   └── findings.md              # 自動生成される参照ルール
└── .tanaoroshi/
    └── logs/
        ├── pending/             # 未処理ログ
        └── {year}/{month}/      # 処理済みログ
```

## 設定

プロジェクトルートに `.tanaoroshi.json` を作成：
```json
{
  "outputDir": ".claude/findings",
  "categories": [
    { "name": "docker" },
    { "name": "testing" },
    {
      "name": "decisions",
      "description": "技術選択の理由、方針決定の経緯"
    }
  ]
}
```

| キー | デフォルト | 説明 |
|------|-----------|------|
| `outputDir` | `.claude/findings` | 発見の出力先 |
| `categories` | `[]` | カテゴリ定義の配列 |

### カテゴリの振り分け

1. 設定された `categories` に当てはまる → `{outputDir}/{name}/`
2. どれにも当てはまらない → `{outputDir}/_etc/{autoCategoryName}/`

`_etc/` に同じカテゴリが増えてきたら、`categories` に追加して正式なカテゴリに昇格できる。

## 記録される発見

### 記録すべきもの

- マニュアルに書いてない挙動
- 実際にやってみて初めてわかったこと
- 特定の組み合わせでの挙動
- ハマりポイントと解決策
- ベストプラクティス
- 技術選択の理由と経緯

### 記録しないもの

- 概念の一般的な説明
- 公式ドキュメントのコピー
- 単純な使い方

## 要件

- Claude Code v2.0.12 以上
- jq（セッションログの処理に使用）

## ライセンス

MIT
